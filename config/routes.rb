Rails.application.routes.draw do

  resources :shipments
  resources :payment_methods
  resources :categories
  resources :products
  resources :dashboard
  
  devise_for :admins
  devise_for :users


  #Shop
  get 'shop/index' => 'shop#index', as: 'shop'
  get 'shop/' => 'shop#index'  
  get 'shop/summary' => 'shop#summary', as: 'summary'
  
  get 'shop/order_done' => 'shop#order_done', as: 'order_done'
  post 'shop/payment_methods' => 'shop#pay_methods', as: 'pay_methods'
  get 'shop/payment_methods' => 'shop#pay_methods'


  #Dashboard
  get 'dashboard' => 'dashboard', as: 'dash_board'
 

  #Stock
  get 'shop/stock' => 'shop#stock', as: 'stock'
  get 'shop/delete_stock/:id' => 'stocks#delete_pro_from_stock', as: 'delete_pro_from_stock'
  get 'shop/stock/:pro_id' => 'stocks#add_pro_to_stock', as: 'add_pro_to_stock'


  #User
  get 'shop/show_all_user' => 'users#show_all_user', as: 'show_all_user'
  patch 'dashboard/save_user/:id' => 'users#update_user', as:'save_user'
  get 'dashboard/edit_user/:id' => 'users#edit_user', as: 'edit_user' 
  get 'users/sign_in' => 'users#sign_in', as: 'users_sign_in'
  
  #Oders
  get 'orders' =>'orders#index', as:'orders'
  get 'shop/orders' => 'orders#index', as: 'show_orders'
  get 'orders/prepare_order/:id' => 'orders#prepare_order', as: 'prepare_order'
  post 'orders/save_order' => 'orders#save_order', as: 'save_order'
  get 'orders/add_pro_to_order/'=> 'orders#add_pro_to_order', as: 'add_pro_to_order'
  post 'orders/prepare_order'=>'orders#put_pro_in_order', as: 'put_pro_in_order'
  get 'orders/prepare_order/:id'=>'orders#put_pro_in_order', as: 'put_pro_in_order_get'
  get 'orders/delete/:order_id' => 'orders#delete_order', as: 'delete_order'
  root to:'shop#index'


  #Shipment
  get 'shop/shipments' => 'shop#shipments', as: 'show_shipments'



  

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
