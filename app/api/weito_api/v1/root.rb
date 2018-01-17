class WeitoAPI::V1::Root < Grape::API
	version 'v1', using: :path
  format :txt
  mount WeitoAPI::V1::Test
end