require 'api_constraints'
Rails.application.routes.draw do


  devise_for :organizations
  get 'pages/home'

  get 'pages/help'

  get 'pages/contact'

  get 'pages/about'

  get 'pages/menu'

  get 'pages/order'

  get 'items/show'

  get 'pages/today'

  root 'pages#home'


  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :menus
  resource :items
  resources :courses
  resources :first_courses, controller: 'courses', type: 'FirstCourse'
  resources :second_courses, controller: 'courses', type: 'SecondCourse'
  resources :drinks, controller: 'courses', type: 'Drink'


  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :organizations, :only => [:show]
      resources :users, :only => [:show, :index]
      resources :sessions, :only => [:create, :destroy]
      resources :orders, :only => [:index]
      # We are going to list our resources here
    end
  end
  resources :orders
  resources :users
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
