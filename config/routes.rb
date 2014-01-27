Lifted::Application.routes.draw do
  root to: "logs#index"
  get "/users/:authentication_token/logs/new", to: "logs#new", as: :user_log
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :logs, only: [:index, :create]
    end
  end

  if Rails.env.development?
    mount NotificationsPreview => "notifications"
  end
end
