Rails.application.routes.draw do
  resources :artists do
    resources :albums, only: [:create, :new, :index, :destroy]
  end
  resources :albums, only: [:index, :show, :edit, :update, :destroy]
  post 'csv', to: 'artists#csv', as: :artist_csv
  post 'artist_search', to: 'artists#search', as: :artist_search
  get 'artist_search', to: 'artists#index'
  root to: 'artists#index'
end
