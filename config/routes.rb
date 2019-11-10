Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  
  namespace :api do
    namespace :v1 do
      resources :archives, only: [:create, :index, :update, :destroy]
      resources :folders, only: [:create, :index, :update, :destroy]
      get '/archives_by_folder/:id', to: 'archives#archives_by_folder'
      get '/folders_by_folder/:id', to: 'folders#folders_by_folder'
    end
  end

  get '/*a', to: 'application#not_found'
end
