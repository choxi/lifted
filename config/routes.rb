Lifted::Application.routes.draw do
  root to: 'landing#show'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :logs, only: [:index, :create]
    end
  end
end
