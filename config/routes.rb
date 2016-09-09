Rails.application.routes.draw do
  root :to => 'categories#index'
  resources :categories do
    resources :products
  end
  resources :products do
    resources :reviews
  end
end
