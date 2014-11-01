Rails.application.routes.draw do
  get 'nodes/index'
  root 'nodes#index'

  devise_for :users
##  devise_for :users

  # Defines the routes supported by the Application. This is the source
  # file used by the Router to evaluate the supported routes
  # to view all this routes use the command rake routes

  #<%= link_to 'Patient Record', patient_path(@patient) %>
  #get '/patients/:id', to: 'patients#show', as: 'patient'
  post '/nodes/:id/update', to: 'nodes#update', as: 'nodeupdate'

	resources :nodes #, only: [:index , :show, :edit, :create, :update]
	resources :node_attrbs #[:show] #, :new, :create, :edit, :update]

	resources :nodes do
	  resources :node_attrbs
	end

  # resources :journals, only: [:index, :show, :new, :create, :edit, :update]
end
