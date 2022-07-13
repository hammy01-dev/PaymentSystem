Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'devise/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'plans#index'
  resources :plans , only: [:index ,:create, :new ,:update ,:delete] do
    resources :features , only: [:index, :create ,:new ,:update, :delete]
  end

end
