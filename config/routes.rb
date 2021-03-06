# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :contacts, only: %i[index create update destroy]

  get '/contacts/:id/contact_versions', to: 'contacts#history', as: 'history'
end
