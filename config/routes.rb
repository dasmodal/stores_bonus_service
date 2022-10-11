Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :shops, except: %i[destroy] do
        post :buy, on: :member
      end
      resources :users, except: %i[destroy]
      resources :cards, only: %i[index show]
    end
  end
end
