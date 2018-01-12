Rails.application.routes.draw do
  devise_for :users

  # 前台只需要action:index和show
  # 此行程式同 resources :restaurants, except: [:new, :create, :edit, :update, :destroy]
  resources :restaurants, only: [:index, :show] do
    # 巢狀資源(nested resources)
    resources :comments, only: [:create, :destroy]
  end
  
  # setup category resources for public users
  resources :categories, only: :show
  root "restaurants#index"

  # => profile的路由
  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end
