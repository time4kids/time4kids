Rails.application.routes.draw do
  devise_for :users
  # scope "/admin" do
  #   resources :users
  # end

  root 'welcome#index'
end
