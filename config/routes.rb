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
    resources :messages, only: [:create] # I'm too lazy to replace simple form on chats#show, so I'm leaving this here to avoid the error
  end

  resources :demo_actions, only: [:index] do
    collection do
      get :steph_response
      get :alex_proposal
    end
  end
end
