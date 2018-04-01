module Gw2Api
  module Public
    class Achievements < Base
      attr_reader :achievements_list
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "achievements").connection
      end

      def achievements_list
        @achievements_list ? @achievements_list : fetch_list_detail
      end

      def fetch_list_detail
        results = []
        achievements_ids.each_slice(100) do |ids|
          connection = Gw2Api::Connection.new(path: "achievements",params: {ids: ids.join(',')}).connection
          response = connection.get
          Gw2Error.new("#{self.class} api response unsuccessful with code #{response.status}") if response.status != 200
          result = self.class.parse_json(response.body)
          result.each do |achievement|
            begin
              record = Gw2::Achievement.find_by("gw2_achievement.id": achievement["id"])
            rescue Mongoid::Errors::DocumentNotFound
              record = nil
            end
            if record
              record.gw2_achievement = achievement
              record.save
            else
              Gw2::Achievement.create(gw2_achievement: achievement)
            end
            Rails.logger.info "#{achievement["id"]} has been retrieved!"
          end
          results += result
        end
        @achievements_list = results
      end

      def achievements_ids
        self.response_body
      end
    end
  end 
end