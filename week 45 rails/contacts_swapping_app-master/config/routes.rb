Rails.application.routes.draw do
  resources :users, :has_many => :comments, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: [:index]
  end

  resources :contacts, only: [:create, :destroy, :show, :update], :has_many => :comments
  resources :contact_shares, only: [:create, :destroy], :has_many => :comments
  # get '/users' => 'users#index', :as => 'users'
  # post '/users' => 'users#create'
  # get '/users/new' => 'users#new', :as => 'new_user'
  # get '/users/:id/edit' => 'users#edit', :as => 'edit_user'
  # get '/users/:id' => 'users#show', :as => 'user'
  # patch '/users/:id' => 'users#update'
  # put '/users/:id' => 'users#update'
  # delete '/users/:id' => 'users#destroy'
end
