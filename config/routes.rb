Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      resources :users, only: [:show, :create]
      resources :recipes
      put 'users', to: 'users#update'
    end
  end
end
