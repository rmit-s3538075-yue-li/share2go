Rails.application.routes.draw do
  


  root 'cars#index'

  
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :bookings
  resources :locations
  resources :cars
  resources :charges
  resources :reports
  resources :ratings

  resources :users do
    member do
      get :confirm_email
      get "dashboard" => "users#dashboard"
      get "pick_up" => "users#pick_up_car"
      get "choose_return_location" => "users#choose_return_location"
      get "returned_car" => "users#returned_car"
      get "set_return_location" => "users#set_return_location"
      get "history" => "users#history"
    end
  end
    
  resources :admins do
    member do
      get "dashboard"=> "admins#dashboard"
    end
  end


  get "login" => "sessions#new"
  get "admin-login" => "sessions#new_admin"
  get "register" => "users#new"
  get "logout" => "sessions#destroy"
  get "logoutadmin" => "sessions#destroy_admin"
  
  get "faq" => "footer#faq"
  get "about" => "footer#about"
  get "contact" => "footer#contact"
  
  get "profile" => "users#profile"
  get "topup" => "charges#new"
  
  get "car_list" => "cars#list"
  get "car_detail" => "cars#car_detail"
  get "cancel_booking" => "admins#cancel_booking"
    
  post "login" => "sessions#create"
  post "admin-login" => "sessions#create_admin"
  
  
  # get 'footer/about'
  # get 'footer/faq'
  # get 'footer/contact'
  
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
