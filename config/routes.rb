Rails.application.routes.draw do
  devise_for :users
  root :to => 'categories#index'
  resources :categories do
    resources :products
  end
  resources :products do
    resources :reviews do
      member do
        post 'upvote'
        post 'downvote'
      end
    end
  end
  resources :users, only: :show
end
