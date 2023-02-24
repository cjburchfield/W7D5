Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:new, :create, :edit, :show, :index, :destroy, :update]
  resource :session, only: [:new, :destroy, :index]


  

end
