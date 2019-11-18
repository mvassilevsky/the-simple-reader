Rails.application.routes.draw do
  authenticated :user do
    root 'feeds#index', as: :authenticated_root
  end

  unauthenticated do
    root 'home#index'
  end

  devise_for :users

  resources :feeds, except: :edit
end
