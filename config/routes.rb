Rails.application.routes.draw do
  root 'triangles#index'

  resources :triangles, only: [:index, :new, :create]
end
