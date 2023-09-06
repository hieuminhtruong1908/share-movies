Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'homes#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  scope :movies do
    post 'share', to: 'homes#share', as: :movies_share
  end
end
