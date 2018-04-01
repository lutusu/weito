module Gw2Api
  module Account
    class Achievements < Base
      attr_reader :achievements_list
      def initialize
        super
        @connection = Gw2Api::Connection.new(path: "account/achievements").connection
      end

      def achievements_list
        @achievements_list ? @achievements_list : fetch_list_detail
      end

      def fetch_list_detail
        connection = Gw2Api::Connection.new(path: "account/achievements").connection
      end

      def achievements_ids
        respose_body
      end
    end
  end 
end