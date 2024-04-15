Rails.application.routes.draw do
  namespace :public do
    get 'theme_tags/new'
    get 'theme_tags/edit'
  end
  get 'theme_tags/new'
  get 'theme_tags/edit'
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
    resources :end_users, only: [:show, :edit]
    resources :themes
    get 'choice' => 'homes#choice', as: 'choice'
    get 'end_users/confirm' => 'end_users#confirm', as: 'end_user_confirm'
    get 'themes/confirm' => 'themes#confirm', as: 'theme_confirm'

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
