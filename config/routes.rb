Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :ideas do  
    member do
      patch :move
    end
  end
  resources :memos do
    member do
      patch :move
    end
  end
end
