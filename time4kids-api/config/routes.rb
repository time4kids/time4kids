Rails.application.routes.draw do
  devise_for :users, only: []
  # scope "/admin" do
  #   resources :users
  # end

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :authentication, only: [:create]
    end
  end

  root 'welcome#index'
end
