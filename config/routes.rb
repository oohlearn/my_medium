Rails.application.routes.draw do
  devise_for :users, controllers: {
    registration: "users/registrations"
  }
  # 告訴他，我有自己客製化的，不要用內建預設的
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :stories
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  

  # Defines the root path route ("/")
  root "pages#index"
end
