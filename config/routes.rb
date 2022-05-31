Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :toilets, only: %i[new create edit update show index destroy] do
    collection do
      get :golden
    end
    resources :reviews, only: %i[new create show index destroy]
    resources :favorites, only: %i[new create index destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
