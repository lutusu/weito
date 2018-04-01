describe WeitoAPI::Root do
  context 'GET /api/v1/test' do
    it 'finds v1 test and return json hello message' do
      get '/api/v1/test'
      expect(response.status).to eq(200)
      expect(response.body).to eq({message: 'Hello v1 here'}.to_json)
    end
  end
  context 'GET /api/v2/test' do
    it 'it find v2 test returns xml hello message' do
      get '/api/v2/test'
      expect(response.body).to eq({message: 'Hello v2 here'}.to_xml)
    end
  end

  context 'GET /api/v1/test_wrapped/wrapped_test' do
    it 'finds endpoints in namespace and returns wrapped_test as txt' do
      get '/api/v1/test_wrapped/wrapped_test'
      expect(response.body).to eq("wrapped_test")
    end
  end
  context 'GET /api/v1/heaven/prophet' do
    it 'is destiny even you do nothing' do
      get '/api/v1/heaven/prophet'
      expect(response.body).to eq({destiny: :decided}.to_json)
    end
  end
  context 'GET /api/v1/heaven/will' do
    it 'nothing is certained in heaven' do  
      expect{ get '/api/v1/heaven/will' }.to  change { User.count }.by(1)
      expect(response.body).to eq({destiny: :doomed}.to_json)
    end
  end
  context 'GET /api/v1/heaven' do
    it 'require a pass' do
      get '/api/v1/heaven?pass=1'    
      expect(response.status).to eq(200)
    end
  end
  context 'GET /api/v1/breakin' do
    it 'walks around the guard' do
      get '/api/v1/breakin'    
      expect(response.status).to eq(200)
    end
  end
  context 'GET /api/v1/guard' do
    it 'the evil guard robbed your pass' do
      get '/api/v1/guard?pass=mypass'    
      expect(response.body).to eq(nil.to_json)
    end
  end
end