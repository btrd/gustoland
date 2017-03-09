Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'

      resources :users, except: [:update] do
        post   'follow', to: 'users#follow'
        delete 'follow', to: 'users#unfollow'
      end
      put 'users', to: 'users#update'

      resources :recipes do
        post   'like',     to: 'recipes#like'
        delete 'like',     to: 'recipes#unlike'
        post   'book',     to: 'recipes#book'
        delete 'book',     to: 'recipes#unbook'
        post   'ask_more', to: 'recipes#ask_more'
        resources :comments, only: :create
      end
      get 'recipes_search', to: 'search#index'

      resources :comments, except: :create
      resources :tags, only: :index

      get 'notifications', to: 'notifications#index'
    end
  end
end
