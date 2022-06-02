Rails.application.routes.draw do
  # get 'favorites/new' --> can be deleted? floreba
  # get 'favorites/create' --> can be deleted? floreba
  # get 'favorites/destroy' --> can be deleted? floreba
  get 'favorites/index'
  devise_for :users
  root "pages#home"
  #get "toilet/:toilet_id/path", to "toilet#show"
  resources :toilets, only: %i[new create edit update show index] do
    collection do
      get :golden
    end
    resources :reviews, only: %i[new create show index]
    resources :favorites, only: %i[create]
    # delete "reviews/:id", to: "reviews#destroy", as: :delete_review
  end
  resources :reviews, only: %i[destroy]
  delete "toilets/toilet_id/favorites/:id", to: "favorites#destroy", as: :delete_favorite
  # delete "toilets/:toilet_id/reviews/:id", to: "reviews#destroy", as: :delete_review
  delete "toilets/:id", to: "toilets#destroy", as: :delete_toilet

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
