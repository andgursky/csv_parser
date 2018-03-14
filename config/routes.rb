require 'resque_web'

Rails.application.routes.draw do
  post 'uploader/upload', as: 'uploader'
  root to: 'suppliers#index'

  resources :products
  resources :suppliers do
    member do
      get '/products', action: :products
    end
  end

  mount ResqueWeb::Engine => '/resque'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
