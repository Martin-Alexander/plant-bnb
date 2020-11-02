Rails.application.routes.draw do
  root to: "plants#index"

  devise_for :users

  resources :plants do
    resources :favourites, only: [:index]
    resources :plant_interests, only: [:create]

    member do
      get :chats, to: "plant_chats#index"
    end
  end

  resources :favourites, only: [:index, :destroy]
  resources :my_plants, only: [:index]
  resources :categories, only: [:show]

  resources :chats, only: [:show, :index] do
    resources :messages, only: [:create]
  end
end
