Rails.application.routes.draw do
  # get 'favorites/new' --> can be deleted? floreba
  # get 'favorites/create' --> can be deleted? floreba
  # get 'favorites/destroy' --> can be deleted? floreba
  # get 'favorites/index'
  devise_for :users
  root "pages#home"
  resources :favorites, only: %i[index]
  #get "toilet/:toilet_id/path", to "toilet#show"
  resources :toilets, only: %i[new create edit update show index] do
    collection do
      get :golden
    end
    resources :reviews, only: %i[new create edit update show index]
    resources :favorites, only: %i[create]
  end
  get "dashboard", to: "pages#dashboard"
  resources :reviews, only: %i[destroy]

  delete "toilets/:id", to: "favorites#destroy", as: :delete_favorite
  delete "toilets/:id", to: "toilets#destroy", as: :delete_toilet
end
