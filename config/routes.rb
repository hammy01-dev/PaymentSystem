# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to: 'plans#index'

  resources :plans do
    resources :features, only: %i[index create new]
    resource :subscriptions, only: %i[create]
    resource :charges, only: %i[create new]
  end
  resource :subscriptions, only: %i[show]

  resources :features, only: %i[update destroy edit]
  resources :usages

  get 'usages/user/:id/plans', to: 'usages#plan'
  get 'usages/user/:id/features', to: 'usages#features'
  get 'transactions', to: 'transactions#abc'
end
