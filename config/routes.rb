Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      post 'sessions', to: 'sessions#index'
      get '/backgrounds', to: 'images#background'
      post 'users', to: 'users#create'
    end
  end
end
