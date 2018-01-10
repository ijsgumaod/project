Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'
  #delete '/logout', to: 'sessions#destroy', as: :logout
  get '/sign_up', to: 'users#new', as: :sign_up

  resources :users do
    resources :posts do
      resources :comments
    end
    #get '/user/account-settings', to: 'user/s#edit', as: :user_edit
    resources :admins
  end

  resources :sessions
  get '/login', to: 'sessions#new', as: :login
end
