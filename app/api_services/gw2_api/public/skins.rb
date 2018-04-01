module Gw2Api
  module Public
    class Skins < Base
      attr_reader :skins
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "minis").connection
      end

      def skins
        results = []
        skins_ids.each_slice(100) do |ids|
          connection = Gw2Api::Connection.new(path: "minis",params: {ids: ids.join(',')}).connection
          response = connection.get
          Gw2Error.new("#{self.class} api response unsuccessful with code #{response.status}") if response.status != 200
          result = self.class.parse_json(response.body)
          result.each do |skin|
            begin
              record = Gw2::Skin.find_by("gw2_skin.id": skin["id"])
            rescue Mongoid::Errors::DocumentNotFound
              record = nil
            end
            if record
              record.gw2_skin= masterie
              record.save
            else
              Gw2::Skin.create(gw2_skin: skin)
            end
            Rails.logger.info "#{skin["id"]} has been retrieved!"
          end
          results += result
        end
        @skins_list = results
      end

      def skins_ids
        self.response_body
      end
    end
  end 
end