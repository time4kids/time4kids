Rails.application.routes.draw do
  devise_for :users, only: []

  namespace :api, defaults: { format: :json } do
    scope module: :v1, path: 'v1' do
      resources :authentication, only: [:create]
      resources :registration, only: [:create, :update]

      # catch missing routes and return 404
      match "*path", to: -> (env) { [404, {}, ['{"error": "not_found"}']] }, via: :all
    end
  end

  root 'welcome#index'
end
