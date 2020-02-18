Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :ideas do 
    resources :memos, only: [:create, :show, :edit, :update]
  end
  resources :memos do 
    put :sort
  end
end
