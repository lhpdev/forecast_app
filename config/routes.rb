Rails.application.routes.draw do
  get "dashboard/index"
  post 'dashboard/search', to: "dashboard#search"
  get 'dashboard/forecast', to: "dashboard#forecast"
  
  root "dashboard#index"
end
