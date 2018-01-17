class WeitoAPI::V1::Test < Grape::API

	desc "test api"
	get "test" do
		{a: 1}
	end
	namespace '' do
		format 'json'
		desc "test json"
		get 'json_result' do
			{b:2}
		end
	end	
end