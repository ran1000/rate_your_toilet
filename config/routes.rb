Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  resources :toilets, only: %i[new create edit update show index] do
    collection do
      get :golden
    end
    resources :reviews, only: %i[new create show index]
    resources :favorites, only: %i[new create index destroy]
    # delete "reviews/:id", to: "reviews#destroy", as: :delete_review
  end
  resources :reviews, only: %i[destroy]
  # delete "toilets/:toilet_id/reviews/:id", to: "reviews#destroy", as: :delete_review
  delete "toilets/:id", to: "toilets#destroy", as: :delete_toilet

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
