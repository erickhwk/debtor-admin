Rails.application.routes.draw do
  resources :profiles
  root 'pages#index'

  resources :companies
  resources :reports do
    member do
      delete :remove_file
      delete :remove_all_files
    end
  end
  resources :lawsuits
  resources :tenancies
  devise_for :users
end
