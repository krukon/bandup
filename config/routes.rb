Bandup::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static#home'

  resources :artists, only: [:index, :show, :edit, :destroy, :create]
  get 'signup' => 'artists#new', as: 'signup'
  patch 'artists/:id/edit' => 'artists#update', as: 'update_artist'
  get 'artists/:id/bands' => 'artists#bands', as: 'bands_of_artist'

  # Band routes
  resources :bands, only: [:index, :show, :edit, :destroy], id: /[\w\-\.\~]+/
  get   'create-band'    => 'bands#new',    as: 'new_band'
  post  'create-band'    => 'bands#create', as: 'create_band'
  patch 'bands/:id/edit' => 'bands#update', as: 'update_band', id: /[\w\-\.\~]+/

  # Artist: Band request/invitation routes
  get    'band-requests'          => 'artists#band_requests',          as: 'requests_to_band'
  post   'invitations/:id/accept' => 'artists#accept_band_invitation', as: 'accept_band_invitation'
  post   'bands/:id/join'         => 'bands#join_request',             as: 'send_band_request'
  delete 'bands/:id/leave'        => 'bands#leave_band',               as: 'leave_band'
  delete 'requests/:id/remove'    => 'artists#remove_band_request',    as: 'remove_band_request'
  delete 'invitations/:id/remove' => 'artists#remove_band_invitation', as: 'remove_band_invitation'

  # Band->Artist request/invitation routes
  scope 'bands/:id' do
    get    'requests'                     => 'bands#requests',          as: 'band_requests'
    get    'members'                      => 'bands#members',           as: 'band_members'
    post   'invite'                       => 'bands#invite_artist',     as: 'invite_artist'
    post   'requests/:username/accept'    => 'bands#accept_request',    as: 'accept_request_to_band'
    delete 'members/:username'            => 'bands#remove_member',     as: 'remove_artist_from_band'
    delete 'invitations/:username/remove' => 'bands#remove_invitation', as: 'remove_invitation_to_band'
    delete 'requests/:username/remove'    => 'bands#remove_request',    as: 'remove_request_to_band'
  end

  # Post routes (temporarily)
  resources :posts, except: [:edit, :update]

  # Session routes - signin, signout
  get 'signin' => 'session#new', as: 'signin'
  post 'signin' => 'session#create', as: 'create_session'
  delete 'signout' => 'session#destroy', as: 'signout'

  # Pictures controller routes
  resources :pictures, path_names: { new: 'upload', create: 'upload' }
  get 'artists/:username/pictures'     => 'pictures#artist_index',    as: 'artist_pictures'
  get 'artists/:username/pictures/:id' => 'pictures#artist_show',     as: 'artist_picture'
  get 'select-profile-picture'         => 'pictures#select_profile',  as: 'select_profile_picture'
  get 'select-profile-picture/:id'     => 'pictures#change_profile',  as: 'change_profile_picture'

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
