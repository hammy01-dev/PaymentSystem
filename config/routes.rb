Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { invitations: 'devise/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "plans#index"
  resources :plans
end
