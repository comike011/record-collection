Rails.application.routes.draw do
  resources :artists do
    resources :albums
  end
  resources :albums, only: [:index, :show]
  root to: 'artists#index'
end
