Rails.application.routes.draw do
  root 'pages#index'
  
  namespace :api do
    namespace :v1 do
      resources :reports, only: [:index]
      resources :lawsuits, only: [:index]
      resources :companies, only: [:index]
    end
  end

   # Rotas do Active Storage
   direct :rails_blob do |blob|
    route_for(:rails_blob, blob)
  end

  direct :rails_blob_proxy do |blob|
    route_for(:rails_blob_proxy, blob)
  end

  direct :rails_representation do |representation|
    route_for(:rails_representation, representation)
  end

  direct :rails_representation_proxy do |representation|
    route_for(:rails_representation_proxy, representation)
  end
  
  resources :profiles
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
