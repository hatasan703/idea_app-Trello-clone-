Rails.application.routes.draw do
  devise_for :users
  root "top#index"

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
