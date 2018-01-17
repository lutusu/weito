require 'grape-swagger'

class WeitoAPI::Root < Grape::API
	format :json
	mount WeitoAPI::V1::Root
	mount WeitoAPI::V2::Root

  # add_swagger_documentation \
  # base_path: proc { '/' }
end