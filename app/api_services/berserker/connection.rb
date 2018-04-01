module Berserker
  class Connection
    
    def initialize options = {}
      @connection = Faraday.new(options) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.headers[:Authorization] = "Bearer #{WeitoResource.resources[:gw2_token]}"
      end
    end

    def connection
      @connection
    end

  end
end