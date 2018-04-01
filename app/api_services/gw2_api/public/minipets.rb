module Gw2Api
  module Public
    class Minipets < Base
      attr_reader :minipets
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "minis").connection
      end

      def minipets
        results = []
        minipets_ids.each_slice(100) do |ids|
          connection = Gw2Api::Connection.new(path: "minis",params: {ids: ids.join(',')}).connection
          response = connection.get
          Gw2Error.new("#{self.class} api response unsuccessful with code #{response.status}") if response.status != 200
          result = self.class.parse_json(response.body)
          result.each do |minipet|
            begin
              record = Gw2::Minipet.find_by("gw2_minipet.id": minipet["id"])
            rescue Mongoid::Errors::DocumentNotFound
              record = nil
            end
            if record
              record.gw2_minipet= masterie
              record.save
            else
              Gw2::Minipet.create(gw2_minipet: minipet)
            end
            Rails.logger.info "#{minipet["id"]} has been retrieved!"
          end
          results += result
        end
        @minipets_list = results
      end

      def minipets_ids
        self.response_body
      end
    end
  end 
end