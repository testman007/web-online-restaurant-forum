Rails.application.routes.draw do
  devise_for :users

  # 前台只需要action:index和show
  # 此行程式同 resources :restaurants, except: [:new, :create, :edit, :update, :destroy]
  resources :restaurants, only: [:index, :show] do
    # 巢狀資源(nested resources)
    resources :comments, only: [:create, :destroy]
    
    # 瀏覽所有餐廳的最新動態
    # 網址 Helper 使用複數的 restaurants
    collection do
      get :feeds 
      #
      get :ranking 
    end

    # 瀏覽個別餐廳的 Dashboard
    # 網址 Helper 使用單數的 restaurant
    # 網址會帶入餐廳物件的 id，讓你可以在 Action 裡設定 
    member do
      get :dashboard
      # 設定 favorite 路由
      post :favorite
      post :unfavorite
      # 設定 like 路由
      post :like
      post :unlike
    end

  end
  
  # setup category resources for public users
  resources :categories, only: :show
  root "restaurants#index"

  # => profile的路由
  resources :users, only: [:index, :show, :edit, :update]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

  #
  # 設定「美食達人頁面」的路由
  #
  resources :followships, only: [:create, :destroy]


end
