Rails.application.routes.draw do
  devise_for :users
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
    collection do
      get :public
    end
    member do
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


end
