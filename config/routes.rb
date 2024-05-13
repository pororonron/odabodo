Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  # devise_scope :admin do
  #   get '/admin/sign_out' => 'admin/sessions#destroy'
  # end

  namespace :admin do
    root to: 'homes#top'
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


      # resource :end_users, only: [:edit, :update], as: 'end_user'
      resources :end_users, only: [:show, :edit, :update] do
        collection do
          get :confirm
          patch :withdraw
        end
        member do
          get :follows, :followers
        end
        resource :follow_relationships, only: [:create, :destroy]
      end
      #get 'confirm' => 'end_users#confirm', as: 'end_user_confirm'
      # patch 'withdraw' => 'end_users#withdraw', as: 'withdraw'


    resources :themes do
      get :challenge_themes, on: :member
      resource :challenge_theme, only: [:create, :destroy]
      resources :theme_comments, only: [:create, :destroy]
    end

    resources :illustrations do
      member do
        get :favorites
        get :bookmarks
      end
      resource :favorite, only: [:create, :destroy]
      resource :bookmark, only: [:create, :destroy]
      resources :illustration_comments, only: [:create, :destroy]
    end

    get 'choice' => 'homes#choice', as: 'choice'
    resources :searches, only: [:create, :index]
    get 'search' => 'searches#search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
