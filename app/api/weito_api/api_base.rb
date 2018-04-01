require 'grape_logging'
module WeitoAPI
	module ApiBase
		extend ActiveSupport::Concern

		included do
			def logger
				WeitoAPI::Root.logger
			end
			
			
		end
	end
end