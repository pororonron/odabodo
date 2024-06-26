Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  # devise_scope :admin do
  #   get '/admin/sign_out' => 'admin/sessions#destroy'
  # end

  namespace :admin do
    root to: 'homes#top'
    resources :homes, only: [] do
      collection do
        get :choice, :search, :search_tag, :theme_and_illustration, :comment, :end_users
      end
    end

    resources :end_users, only: [:show, :edit, :update] do
      member do
        get :follows, :confirm
        patch :withdraw
      end
      # resource :follow_relationships, only: [:create, :destroy]
    end

    resources :themes do
      member do
        get :challenge_themes, :challenged_image
        patch :withdraw
      end
      # resource :challenge_theme, only: [:create, :destroy]
      resources :theme_comments, only: [:destroy]
    end

    resources :illustrations do
      member do
        get :favorites, :bookmarks
      end
      # resource :favorite, only: [:create, :destroy]
      # resource :bookmark, only: [:create, :destroy]
      resources :illustration_comments, only: [:destroy]
    end
  end

  scope module: :public do
    devise_for :end_users, skip: [:passwords], controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions'
    }
    devise_scope :end_user do
      post 'end_users/guest_sign_in', to: 'sessions#guest_sign_in'
    end

    root to: 'homes#top'

    resources :homes, only: [] do
      collection do
        get :choice, :search, :search_tag
      end
    end

    resources :end_users, only: [:show, :edit, :update] do
      collection do
        get :confirm
        patch :withdraw
      end
      member do
        get :follows
      end
      resource :follow_relationships, only: [:create, :destroy]
    end

    resources :themes do
      member do
        get :challenge_themes, :challenged_image
        patch :withdraw
      end
      resource :challenge_theme, only: [:create, :destroy]
      resources :theme_comments, only: [:create, :destroy]
    end

    resources :illustrations do
      member do
        get :favorites, :bookmarks
      end
      resource :favorite, only: [:create, :destroy]
      resource :bookmark, only: [:create, :destroy]
      resources :illustration_comments, only: [:create, :destroy]
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
