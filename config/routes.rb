Rails.application.routes.draw do
  devise_for :users
  root :to => 'categories#index'
  resources :categories do
    resources :products
  end
  resources :products do
    member do
      patch 'crop'
    end
  end

  mount ActionCable.server => '/cable'
  resources :chat_rooms, param: :slug
  resources :chat_messages

  match "/upvote/:id" => "reviews#upvote", :via => :post, :as => :upvote
  match "/downvote/:id" => "reviews#downvote", :via => :post, :as => :downvote
  match "/show_prod/:id" => "users#show_prod", :via => :post, :as => :show_prod
  match "/about/" => "categories#about", :via => :get, :as => :about
  match "/contact" => "categories#contact", :via => :get, :as => :contact
  match "/direct_message/:id" => "messages#direct_message", :via => :post, :as => :direct_message

  resources :users, only: :show do
    resources :reviews
  end
  resources :messages, only: [:new, :create]

  # Great to remember for future routing
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
