module Gw2Api
  module Public
    class Titles < Base
      attr_reader :titles,:connection
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "titles").connection
      end
      
      def titles
        return @titles if @titles.present?
        detail_connection = Gw2Api::Connection.new(path: "titles",params:{ids: title_ids.join(",")}).connection
        response = detail_connection.get
        @titles = self.class.parse_json(response.body)
        @titles.each do |title|
          begin
            record = Gw2::Title.find_by("gw2_title.id": title["id"])
          rescue Mongoid::Errors::DocumentNotFound
            record = nil
          end
          if record
            record.gw2_title = title
            record.save
          else
            Gw2::Title.create(gw2_title: title) rescue nil
          end
        end
        @titles
      end

      def title_ids
        response_body
      end
    end
  end 
end