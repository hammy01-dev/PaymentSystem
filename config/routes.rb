# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'devise/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'plans#index'
  resources :plans, only: %i[index create new update destroy] do
    resources :features, only: %i[index create new]
    resource :subscriptions, only: [:create]
  end
  resources :features, only: %i[update destroy edit]
  resources :usages
  get 'usages/user/:id/plans', to: 'usages#plan'
  get 'usages/user/:id/features', to: 'usages#features'
  get 'transactions', to:'transactions#abc'
end
