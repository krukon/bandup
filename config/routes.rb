Bandup::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'static#home'

  resources :artists, only: [:index, :show, :edit, :destroy, :create]
  get 'signup' => 'artists#new', as: 'signup'
  patch 'artists/:id/edit' => 'artists#update', as: 'update_artist'
  get 'artists/:id/bands' => 'artists#bands', as: 'bands_of_artist'
  get 'band-requests' => 'artists#band_requests', as: 'band_requests'

  resources :bands, only: [:index, :show, :edit, :destroy],
                    constraints: { id: /[\w\-\.\~]+/}
  get 'create-band' => 'bands#new', as: 'new_band'
  post 'create-band' => 'bands#create', as: 'create_band'
  patch 'bands/:id/edit' => 'bands#update', as: 'update_band',
                    constraints: { id: /[\w\-\.\~]+/}
  post 'bands/:id/accept-request' => 'bands#accept_request', as: 'accept_band_request'
  delete 'bands/:id/remove-request' => 'bands#remove_request', as: 'remove_band_request'
  post 'bands/:id/join' => 'bands#join_request', as: 'join_request'
  post 'bands/:id/invite-artist' => 'bands#invite_artist', as: 'invite_artist'

  # Session routes - signin, signout
  get 'signin' => 'session#new', as: 'signin'
  post 'signin' => 'session#create', as: 'create_session'
  delete 'signout' => 'session#destroy', as: 'signout'

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
