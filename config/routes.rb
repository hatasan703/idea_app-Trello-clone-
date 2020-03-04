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

  # resources :ideas do 
  #   resources :memos, only: [:create, :show, :edit, :update, :destroy]
  # end
  resources :lists do  
    member do
      patch :move
    end
  end
  resources :cards do
    member do
      patch :move
    end
  end

  
end
