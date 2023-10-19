require 'sidekiq/web'
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"''
  root to: 'homes#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get 'product/index', to: 'homes#product_index'
  post 'product/create', to: 'homes#product_create'
  get 'product/show', to: 'homes#product_show'
  post 'product/update', to: 'homes#product_update'

  mount Sidekiq::Web => "/sidekiq"

  scope :movies do
    post 'share', to: 'homes#share', as: :movies_share
  end
end