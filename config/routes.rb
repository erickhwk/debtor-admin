Rails.application.routes.draw do
  resources :companies
  resources :reports do
    member do
      delete :remove_file
    end
  end
  resources :lawsuits
  resources :tenancies
  devise_for :users
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
