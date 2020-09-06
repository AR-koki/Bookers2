Rails.application.routes.draw do
  root 'home#home'
  get 'home/about' => 'home#about'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index, :create] do
    member do
      get :follows, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  get 'search' => 'searches#search'

end
