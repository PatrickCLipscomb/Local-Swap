Rails.application.routes.draw do

  root :to => 'categories#index'

  devise_for :users, controllers: { sessions: 'users/sessions'}
  resources :users, only: :show do
    resources :reviews
  end

  resources :categories do
    resources :products
  end
  resources :products do
    member do
      patch 'crop'
    end
  end

  match "/upvote/:id" => "reviews#upvote", :via => :post, :as => :upvote
  match "/downvote/:id" => "reviews#downvote", :via => :post, :as => :downvote
  match "/show_prod/:id" => "users#show_prod", :via => :post, :as => :show_prod
  match "/update/:id" => "users#update", :via => :post, :as => :update
  match "/about/" => "categories#about", :via => :get, :as => :about
  match "/contact" => "categories#contact", :via => :get, :as => :contact
  match "/interests" => "categories#interests", :via => :get, :as => :interests
  match "/direct_message/:id" => "messages#direct_message", :via => :post, :as => :direct_message

  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
end
