Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :ideas do 
    resources :idea_memos, only: [:create]
  end
end
