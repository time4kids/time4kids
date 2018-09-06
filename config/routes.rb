Rails.application.routes.draw do
  scope :v1, defaults: { format: :json } do
    devise_for :users,
      path: 'auth',
      path_names: {
        registration: 'register',
        sign_in: 'login',
        sign_out: 'logout'
      },
      controllers: {
        registrations: 'auth/registrations',
        sessions: 'auth/sessions'
      }

    devise_scope :user do
      post 'auth/logout', to: 'auth/sessions#destroy'
    end
  end

  %w[400 401 403 404 422 500].each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end

  match '*path', to: 'errors#show', code: 404, via: :all
end
