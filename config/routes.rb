Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
      resources :users, only: [:show, :create]
      put 'users', to: 'users#update'

      resources :recipes do
        post 'likes', to: 'recipes#like'
        resources :comments, only: :create
      end
      resources :comments, except: :create
      resources :tags, only: :index
    end
  end
end
