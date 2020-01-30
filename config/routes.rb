Rails.application.routes.draw do
  authenticated :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  authenticated :user do
    root 'feeds#index', as: :authenticated_root
  end

  unauthenticated do
    root 'home#index'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :feeds, except: :edit do
    member do
      delete 'unsubscribe', as: 'unsubscribe', to: 'feeds#unsubscribe'
    end
  end

  resources :posts, only: [] do
    member do
      post 'bookmark'
      delete 'bookmark', as: 'unbookmark', to: 'posts#unbookmark'
      post 'mark_read'
    end
  end
end
