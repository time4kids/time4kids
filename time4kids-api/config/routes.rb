Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations, :passwords]

  namespace :api, defaults: { format: :json } do
    scope module: :v1, path: 'v1' do
      devise_scope :user do
        resources :authentications, only: [:create]
        resources :registrations, only: [:create, :update]
      end

      # catch missing routes and return 404
      match "*path", to: -> (env) { [404, {}, ['{"error": "not_found"}']] }, via: :all
    end
  end

  root 'welcome#index'
end
