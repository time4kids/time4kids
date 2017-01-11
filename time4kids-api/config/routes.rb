Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations, :passwords]

  namespace :api, defaults: { format: :json } do
    scope module: :v1, path: 'v1' do
      devise_scope :user do
        post '/authentication' => 'authentication#create'
        get '/failure' => 'authentication#failure'
      end
    end
  end

  root 'welcome#index'
end
