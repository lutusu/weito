module Gw2Api
  class Connection
    def initialize options={}
      options.symbolize_keys!
      @url = WeitoConfig.config[:gw2_api_url]
      path = options.delete(:path)
      url = [@url,path].join('/') if path 
      options[:url] = url
      @connection = Berserker::Connection.new(options).connection
    end
    def connection
      @connection
    end
  end
end