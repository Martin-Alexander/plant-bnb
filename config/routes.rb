Rails.application.routes.draw do
  root to: "plants#index"

  devise_for :users

  resources :plants do
    resources :favourites, only: [:index, :create]
    resources :plant_interests, only: [:create]

    member do
      get :chats, to: "plant_chats#index"
    end
  end

  resources :favourites, only: [:index, :destroy]
  resources :my_plants, only: [:index]

  resources :chats, only: [:show, :index]

  resources :users, only: [] do
    resources :messages, only: [:create]
  end
end
