Rails.application.routes.draw do
  devise_for :users, only: []
  # scope "/admin" do
  #   resources :users
  # end

  namespace :api, defaults: { format: :json } do
    scope module: :v1, path: 'v1' do
      resources :authentication, only: [:create]
    end
  end

  root 'welcome#index'
end
