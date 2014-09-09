Rails.application.routes.draw do
  resources :packages, only: [:index, :show]

  root to: "packages#index"
end
