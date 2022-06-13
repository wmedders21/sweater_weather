Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      get '/backgrounds', to: 'images#background'
      post 'users', to: 'users#create'
      get 'book-search', to: 'search#books'
    end
  end
end
