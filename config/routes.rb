Rails.application.routes.draw do
  resources :wifis, except: [:new, :edit, :show]
  resources :users , only: [:index, :create]

  scope "wifi" do
    get 'near' => 'wifis#near_wifis'
    resources :connections, only: [:index , :create]
    scope "connections" do
      resources :ratings, only: [:create ]
	get 'ratings/:wifi_id' => 'ratings#index'
    end
  end

  scope "user" do
    resources :payment_methods, only: [:create , :index]
    post 'signin' => 'session#create'
    post 'signout' => 'session#destroy'
    put 'update' => 'users#update'
    patch 'update' => 'users#update'
    delete 'delete' => 'users#update'
    post 'forgot_password' => 'session#forgot_password'
    get 'email' => 'verifications#resend_email_confirmation'
    get 'reset_password/:forgot_password_token' => 'verifications#reset_password'
    scope "verify" do
      post 'mobile' => 'verifications#mobile_verify'
      get 'email/:email_token' => 'verifications#email'
      patch 'mobile' => 'verifications#mobile_generate'
    end
    put 'payment_methods' => 'payment_methods#update'
    patch 'payment_methods' => 'payment_methods#update'
  end

  scope "connections" do
    post 'rating/:id' => 'connections#rate'
  end

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
