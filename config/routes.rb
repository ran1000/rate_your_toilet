Rails.application.routes.draw do
  root "pages#home"
  get "dashboard", to: "pages#dashboard"
  get "categories", to: "pages#categories"

  devise_for :users
  resources :favorites, only: %i[index]

  resources :toilets, only: %i[new create edit update show index] do
    collection do
      get :golden
    end
    resources :reviews, only: %i[new create edit update show index]
    resources :favorites, only: %i[create]
  end
  get "dashboard", to: "pages#dashboard"
  get "categories", to: "pages#categories"
  resources :reviews, only: %i[destroy]

  delete "toilets/:id", to: "favorites#destroy", as: :delete_favorite
  delete "toilets/:id", to: "toilets#destroy", as: :delete_toilet
end
