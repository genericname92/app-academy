Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :checkpoints, except: [:show, :index, :new]

  resources :user_comments, only: [:create, :destroy]
end
