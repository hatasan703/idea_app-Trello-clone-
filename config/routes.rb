Rails.application.routes.draw do
  root 'top#index'
  resources :companies, only: [:index, :new, :create]
  resources :companies do
    resources :ideas, only: [:index, :create, :update] do 
      collection do
        get :public
      end
    end
  end
  # namespace :companies do
  #   resources :dashbords
  #   resources :formal_registrations ,param: :token
  # end
  get "accept/:token"=>"companies/formal_registrations#new",param: :token ,as: :inviting
  resources :groups
  resources :joingroups
  resources :management_authorizations ,only: [:edit, :update, :destroy]

  devise_for :users

  resources :companies do
    devise_for :users, controllers: {
      invitations: 'users/invitations',
    }
  end

  devise_scope :user do
    authenticated :user do
      root :to => "top#index", as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end


  resources :users
  resources :ideas do
    resources :plans, only: [:index, :new, :edit, :create, :update]
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

  post  "ideas/:id/comment" => "comments#create"
  resources :comments

  namespace :api, { format: 'json' } do
    resources :likes, only: [:index, :create, :destroy]
  end

end
