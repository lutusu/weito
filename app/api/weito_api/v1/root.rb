class WeitoAPI::V1::Root < Grape::API
	version 'v1', using: :path
  format :json
  mount WeitoAPI::V1::Test
  mount WeitoAPI::V1::Achievements
end