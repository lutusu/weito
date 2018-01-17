class WeitoAPI::V2::Test < Grape::API

	desc "test api"
	get "test" do
		{a: 2}
	end

end