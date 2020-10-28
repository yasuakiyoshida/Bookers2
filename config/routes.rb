Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
  resources "homes", path: 'home', except: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'about'
    end
  end
end
