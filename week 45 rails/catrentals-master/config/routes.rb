Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, except: [:new, :create]
  end

  resources :cat_rental_requests, only: [:new, :create]

end



# at_cat_rental_request_url(@cat, @cat_rental_request)
