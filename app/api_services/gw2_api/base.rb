module Gw2Api
  class Base
    attr_reader :connection,:response,:response_body
    
    def response
      @response ||= @connection.get
    end

    def response_body
      @response_body ? @response_body : @response_body = ActiveSupport::JSON.decode(response.body)
    end
    def self.parse_json json_str
      ActiveSupport::JSON.decode(json_str)
    end
  end
end