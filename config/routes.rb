Meritize::Application.routes.draw do



 

  resources :nominees
  match '/nominees/:id/status', :to => "nominees#toggled_status"

  # match "/nominees/check_email", to: 'nominees#check_email'

mount Ckeditor::Engine => '/ckeditor'


  resources :props

  resources :prop_displays

  get "props/index"

  get "props/new"

  get "props/edit"


  resources :vote_settings
  


  root :to => 'homes#index'
  resources :trial_days
  resources :settings  
  resources :subscriptions  
    
    get "paypal/checkout", to: 'subscriptions#paypal_checkout'
    match"/success", :to=> "subscriptions#success", :as => 'success'

  resources :plans
  get "password_resets/new"
  match '/change_password', :controller => 'users', :action => 'change_password'
  resources :users 
  match '/admin_user', :to =>'users#admin_user'
  match '/adminuser_logs', :to =>'users#adminuser_logs'
  match '/users/:id/delete', :to => "users#destroy"
  match '/users/:id/status', :to => "users#toggled_status"
  match '/history', :to => "subscriptions#history"
  match '/users/validations/check_email', :to=>"users#check_email"
  match '/account_creation', :to =>'users#account_creation'
 
  resources :sessions, :only => [:new,:create,:destroy,:edit]
  root :to => 'sessions#new'
    match 'dashboard' => 'users#dashboard', :as => 'user_root'
    match '/signup', :to =>'users#new'
    match '/signin', :to =>'sessions#new'
    match  '/users/:id/edit',  :to => "users#edit" 
    match '/signout', :to =>'sessions#destroy'
  resources :password_resets
  get "/plan" => "subscriptions#plan"
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
