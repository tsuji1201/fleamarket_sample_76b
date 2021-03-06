Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root 'products#index'

  resources :users do
    member do
      get "logout"
      get "info"
      get "address"
      get "credit"
    end
  end

  resources :products do
    resources :comments, only: :create
    collection do
      get 'get_category_children',defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  resources :credits, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'credits#pay'
    end
  end

  resources :purchase, only: :show do
    member do
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end

  resources :searches, only: :index do
    collection do
      get 'detail_search', to: 'searches#detail_search'
    end
  end

  resources :categories, only: :index

end
