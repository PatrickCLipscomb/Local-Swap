Rails.application.routes.draw do
  devise_for :users
  root :to => 'categories#index'
  resources :categories do
    resources :products
  end
  resources :products do
    resources :reviews
  end
  match "/upvote/:id" => "reviews#upvote", :via => :post, :as => :upvote
  match "/downvote/:id" => "reviews#downvote", :via => :post, :as => :downvote
  match "/show_prod/:id" => "users#show_prod", :via => :post, :as => :show_prod
  resources :users, only: :show
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy]
end
