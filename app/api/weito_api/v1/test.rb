class WeitoAPI::V1::Test < Grape::API
	# prefix 'api'
	# version 'v1'
	resource :tests do
		namespace "test_wrapped" do
			format "txt"
			desc "wrapped test"
			get "wrapped_test" do
				"wrapped_test"
			end
		end

		namespace "heaven" do
			
			before do 
				@destiny = {destiny: :decided}
			end
			after do 
				User.create!
			end
			desc "The Prophet"
			get "prophet" do
				@destiny
			end
			
			desc "Doomed"
			get "will" do
				@destiny = {destiny: :doomed}
			end
		end
		
		desc "test v1 api"
		get "test" do
			{message: 'Hello v1 here'}
		end

		desc "the door to heaven"
		params do
			requires :pass, type: String, desc: 'pass to heaven'
		end
		get "heaven" do

		end

		before_validation do
			params[:pass] = 'pass'
			@destiny = {destiny: :validated}
		end
		
		desc "break the door in"
		params do
			requires :pass, type: String, desc: 'pass to heaven'
		end
		get "breakin" do

		end

		after_validation do
			params[:pass] = nil
		end

		before do
			# binding.pry
		end
		desc "your pass is robbed"
		params do
			requires :pass, type: String, desc: 'pass to heaven'
		end
		get "guard" do
			declared(params)
			params[:pass]
		end
		desc "your pass is robbed"
		get "guard" do
			@destiny
		end

		params do 
			optional :male
			optional :female
			# mutually_exclusive :male, :female
		end
		get "grape_test" do
		end
	end
end