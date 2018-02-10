Rails.application.routes.draw do
  resources :artists do
    resources :albums, only: [:create, :new, :index, :destroy]
  end
  resources :albums, only: [:index, :show, :edit, :update, :destroy]
  root to: 'artists#index'
end
