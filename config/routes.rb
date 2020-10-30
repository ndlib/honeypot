Rails.application.routes.draw do
  mount HealthBit.rack => '/health'
  default_url_options({
    host: Rails.configuration.settings.host,
    port: Rails.configuration.settings.port,
    protocol: Rails.configuration.settings.protocol,
  })

  namespace :api do
    resources :images, controller: 'v1/images', as: :legacy_images, only: [:new, :create] do
    end
    get 'images/*image_path', to: 'v1/images#show', format: false, as: :legacy_image, defaults: {format: :json}
    namespace :v1, as: :v1 do
      resources :images, only: [:new, :create] do
      end
      get 'images/*image_path', to: 'images#show', format: false, as: :image, defaults: {format: :json}
    end
  end

  root 'public#index'

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
