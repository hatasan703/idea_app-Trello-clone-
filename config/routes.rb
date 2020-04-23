Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions'   
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
    resources :ideas, except: [:new, :edit] do 
      collection do
        get :public
      end
      member do
        patch :hidden
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
  # namespace :companies do
  #   resources :dashbords
  #   resources :formal_registrations ,param: :token
  # end
  # get "accept/:token"=>"companies/formal_registrations#new",param: :token ,as: :inviting
  resources :groups
  resources :joingroups, only: [:update, :destroy]
  resources :management_authorizations ,only: [:edit, :update, :destroy]

  resources :users
  resources :ideas, only: [] do
    resources :plans
    resources :comments, only: [:create, :destroy]
    collection do
      get :public
    end
    member do
      get :news
      patch :move
    end
  end
  resources :memos do
    member do
      patch :move
    end
  end

  namespace :api, { format: 'json' } do
    resources :likes, only: [:index, :create, :destroy]
  end
  resources :profiles
  resources :search_user_profiles, only: [:index, :new]

end
