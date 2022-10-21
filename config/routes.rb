# frozen_string_literal: true

Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :shops
    mount VandalUi::Engine, at: '/vandal'
    # your routes go here
  end
end
