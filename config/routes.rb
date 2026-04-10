Rails.application.routes.draw do
  get "health/check"

  namespace :api do
    post "auth/signup", to: "auth/signup#create"
    post "auth/login", to: "auth/sessions#create"
  end
end
