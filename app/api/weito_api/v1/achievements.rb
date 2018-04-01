class WeitoAPI::V1::Achievements < Grape::API
  
  resources :achievements do
    desc "gw2 achievements list"
    params do 
      optional :page, type: Integer
      optional :page_size, type: Integer
    end
    get :index do
      Achievement.all.order_by(doc: :id).page(params[:page]).per(params[:page_size])
    end
  end
end