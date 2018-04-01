module Gw2Api
  module Public
    class Masteries < Base
      attr_reader :masteries
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "masteries").connection
      end

      def masteries
        results = []
        masteries_ids.each_slice(100) do |ids|
          connection = Gw2Api::Connection.new(path: "masteries",params: {ids: ids.join(',')}).connection
          response = connection.get
          Gw2Error.new("#{self.class} api response unsuccessful with code #{response.status}") if response.status != 200
          result = self.class.parse_json(response.body)
          result.each do |mastery|
            begin
              record = Gw2::Mastery.find_by("gw2_mastery.id": mastery["id"])
            rescue Mongoid::Errors::DocumentNotFound
              record = nil
            end
            if record
              record.gw2_mastery= masterie
              record.save
            else
              Gw2::Mastery.create(gw2_mastery: mastery)
            end
            Rails.logger.info "#{mastery["id"]} has been retrieved!"
          end
          results += result
        end
        @masteries_list = results
      end

      def masteries_ids
        self.response_body
      end
    end
  end 
end