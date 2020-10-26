Rails.application.routes.draw do
  root to: "plants#index"

  devise_for :users

  resources :plants do
    resources :favourites, only: [:index, :create, :destroy]
    resources :plant_interests, only: [:create]
    resources :chats, only: [:index]
  end

  resources :favourites, only: [:index]
  resources :my_plants, only: [:index]

  resources :messages, only: [:index]
  resources :chats, only: [:show]

  resources :users, only: [] do
    resources :messages, only: [:create]
  end
end
