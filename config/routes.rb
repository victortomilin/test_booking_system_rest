# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :users, :restaurants, :tables, :schedules, :reservations
    end
  end
end
