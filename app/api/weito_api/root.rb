require 'grape-swagger'
require 'grape-swagger/entity'
require 'grape-swagger/representable'
require 'grape_logging'
require 'rack'
require 'rack/cors'

class WeitoAPI::Root < Grape::API
	logger.formatter = GrapeLogging::Formatters::Default.new
	use GrapeLogging::Middleware::RequestLogger,logger: logger,
	include: [ GrapeLogging::Loggers::Response.new,
						 GrapeLogging::Loggers::FilterParameters.new,
						 GrapeLogging::Loggers::ClientEnv.new,
						 GrapeLogging::Loggers::RequestHeaders.new ]

	use Rack::Cors do
		allow do
			origins '*'
			resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
		end
	end
	
	helpers ApiBase
	format :json


	mount WeitoAPI::V1::Root
	mount WeitoAPI::V2::Root

	add_swagger_documentation \
		api_version: self.version,
		add_version: true


end