Giftsaverzzz::Application.routes.draw do
  root :to => 'welcome#index'
  get '/users/new' => 'users#new', as: "create_account"
  post '/users' => 'users#create'
  get '/users/:username' => 'users#show'
  get '/users/:username/edit' => 'users#edit'
  put '/users/:username' => 'users#update'
  delete '/users/:username' => 'users#destroy'

  get '/users/:username/recipients/new' => 'recipients#new'
  post '/users/:username/recipients' => 'recipients#create'
  get '/users/:username/recipients/:id' => 'recipients#show'
  get '/users/:username/recipients/:id/edit' => 'recipients#edit'
  put '/users/:username/recipients/:id' => 'recipients#update'
  delete '/users/:username/recipients/:id' => 'recipients#destroy'

  get '/users/:username/gifts' => 'gifts#search'
  get '/users/:username/gifts/new' => 'gifts#new'
  get '/users/:username/gifts/search/:asin' => 'gifts#aws_show'
  post '/users/:username/gifts' => 'gifts#create'
  get '/users/:username/gifts/:id' => 'gifts#show'

  get '/sign_in' => 'sessions#new', as: "sign_in"
  get '/sign_out' => 'sessions#destroy', as: "sign_out"
  resources :sessions

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
