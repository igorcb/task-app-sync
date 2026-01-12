Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tasks, only: [ :index ] do
    collection do
      post :sync
    end
  end

  root "tasks#index"
end
