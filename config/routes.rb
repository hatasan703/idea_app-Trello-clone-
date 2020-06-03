Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  } 
  root 'companies#index'
  devise_scope :user do
    authenticated :user do
      root :to => "top#index", as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :companies do
    resources :users, only: :show
    scope module: 'ideas' do
      resources :ideas, except: [:new, :edit] do 
        collection do
          get :public
        end
        member do
          patch :hidden
        end
      end
    end
  end

  resources :companies, only: [] do
    devise_for :users, controllers: {
      invitations: 'users/invitations',
    }
    member do
      delete "users/:user_id" => "companies#destroy_member"
    end
  end

  resources :groups
  resources :joingroups, only: [:update, :destroy]
  resources :management_authorizations ,only: [:edit, :update, :destroy]

  resources :users
  scope module: 'ideas' do
    resources :ideas, only: [] do
      collection do
        get :public
      end
      member do
        get :news
        patch :move
      end
      resources :plans
      resources :comments, only: [:create, :destroy]
      resources :memos do
        member do
          patch :move
        end
      end
    end
    resources :joins
  end

  resources :plans, only: [] do
    resources :plan_comments, only: [:create, :destroy]
  end

  namespace :api, { format: 'json' } do
    resources :likes, only: [:index, :create, :destroy]
  end
  resources :profiles
  resources :search_user_profiles, only: [:index, :new]

  resources :messages, only: :create
  resources :rooms, only: [:create, :show, :index]

end
