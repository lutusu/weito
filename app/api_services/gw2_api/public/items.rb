module Gw2Api
  module Public
    class Items < Base
      attr_reader :items
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "items").connection
      end

      def items
        results = []
        items_ids.each_slice(100) do |ids|
          connection = Gw2Api::Connection.new(path: "items",params: {ids: ids.join(',')}).connection
          response = connection.get
          Gw2Error.new("#{self.class} api response unsuccessful with code #{response.status}") if response.status != 200
          result = self.class.parse_json(response.body)
          result.each do |item|
            begin
              record = Gw2::Item.find_by("gw2_item.id": item["id"])
            rescue Mongoid::Errors::DocumentNotFound
              record = nil
            end
            if record
              record.gw2_item= masterie
              record.save
            else
              Gw2::Item.create(gw2_item: item)
            end
            Rails.logger.info "#{item["id"]} has been retrieved!"
          end
          results += result
        end
        @items_list = results
      end

      def items_ids
        self.response_body
      end
    end
  end 
end