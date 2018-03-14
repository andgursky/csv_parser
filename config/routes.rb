require 'resque_web'

Rails.application.routes.draw do
  post 'uploader/upload', as: 'uploader'
  root to: 'suppliers#index'

  resources :products
  resources :suppliers

  mount ResqueWeb::Engine => '/resque'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
