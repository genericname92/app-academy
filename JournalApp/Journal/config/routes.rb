Rails.application.routes.draw do
  root to: "static_pages#root"
  resources :posts, except: [:new, :edit]
end
