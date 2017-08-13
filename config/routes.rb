Rails.application.routes.draw do
  namespace :v1, defaults: {formats: "json"} do
    resources :games
  end
end
