# frozen_string_literal: true

Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :users, except: %i[destroy]
    resources :shops, except: %i[destroy]
    mount VandalUi::Engine, at: '/vandal'
    # your routes go here
  end
end
