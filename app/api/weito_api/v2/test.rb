class WeitoAPI::V2::Test < Grape::API
	resource :tests do
		desc "test v2 api"
		get "test" do
			{message: 'Hello v2 here'}
		end
	end
end