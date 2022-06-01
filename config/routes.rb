Rails.application.routes.draw do
  # get 'favorites/new' --> can be deleted? floreba
  # get 'favorites/create' --> can be deleted? floreba
  # get 'favorites/destroy' --> can be deleted? floreba
  # get 'favorites/index'
  devise_for :users
  root "pages#home"
  resources :favorites, only: %i[index]

  resources :toilets, only: %i[new create edit update show index] do
    collection do
      get :golden
    end
    resources :reviews, only: %i[new create show index]
    resources :favorites, only: %i[create]
    # delete "reviews/:id", to: "reviews#destroy", as: :delete_review
  end
  get "dashboard", to: "pages#dashboard"
  resources :reviews, only: %i[destroy]

  delete "toilets/toilet_id/favorites/:id", to: "favorites#destroy", as: :delete_favorite
  delete "toilets/:id", to: "toilets#destroy", as: :delete_toilet
end

# delete "toilets/:toilet_id/reviews/:id", to: "reviews#destroy", as: :delete_review
