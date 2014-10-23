Rails.application.routes.draw do
  devise_for :users
##  devise_for :users

  # Defines the routes supported by the Application. This is the source
  # file used by the Router to evaluate the supported routes
  # to view all this routes use the command rake routes



  resources :nodes #, only: [:index , :show, :edit, :create, :update]
  resources :node_attrbs #[:show] #, :new, :create, :edit, :update]


resources :nodes do
  resources :node_attrbs
end

  # resources :journals, only: [:index, :show, :new, :create, :edit, :update]
end
