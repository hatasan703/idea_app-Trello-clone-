Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :ideas do 
    resources :memos, only: [:create, :show]
    put :sort
  end
end
