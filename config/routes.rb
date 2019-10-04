Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  
  namespace :api do
    namespace :v1 do
      resources :archives, only: [:create, :index, :update, :destroy]
    end
  end

  get '/*a', to: 'application#not_found'
end
