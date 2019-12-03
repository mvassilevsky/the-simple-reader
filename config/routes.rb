Rails.application.routes.draw do
  authenticated :user do
    root 'feeds#index', as: :authenticated_root
  end

  unauthenticated do
    root 'home#index'
  end

  devise_for :users

  resources :feeds, except: :edit do
    member do
      delete 'unsubscribe', as: 'unsubscribe', to: 'feeds#unsubscribe'
    end
  end

  resources :posts, only: [] do
    member do
      post 'bookmark'
      delete 'bookmark', as: 'unbookmark', to: 'posts#unbookmark'
    end
  end
end
