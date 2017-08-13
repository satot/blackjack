Rails.application.routes.draw do
  namespace :v1, defaults: {formats: "json"} do
    resources :games do
      member do
        get :winner
        post :deal
        put :finish
      end
    end
  end
end
