Rails.application.routes.draw do
  post 'uploader/upload', as: 'uploader'
  root to: 'uploader#upload'

  resources :products
  resources :suppliers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
