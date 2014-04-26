Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: "omniauth_callbacks",
      registrations: "registrations"
    }
  
  authenticated :user do
    resources :folders do
      resources :invitations
      resources :tasks
      resources :documents
    end
  end
  
  root to: "folders#index"
end
