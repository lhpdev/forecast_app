Rails.application.routes.draw do
  get "dashboard/index"
  post 'dashboard/search', to: "dashboard#search"
  
  root "dashboard#index"
end
