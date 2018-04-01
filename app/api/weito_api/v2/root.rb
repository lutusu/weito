class WeitoAPI::V2::Root < Grape::API
	version 'v1', using: :path
  format :xml
  mount WeitoAPI::V2::Test
end