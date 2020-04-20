Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: %i[create update]
    end
  end
end
