Rails.application.routes.draw do

  post 'warning_messages/hide_message'
  get 'main/change_lang' => 'main#change_lang', :as=> 'main/change_lang'
  get 'map_layers/set_layer' => 'map_layers#set_layer', :as=>  'map_layers/set_layer'
  post 'clients/refresh_map' =>  'clients#refresh_map', :as=>  'clients/refresh_map'
  post 'addresses/refresh_map' =>  'addresses#refresh_map', :as=>  'addresses/refresh_map'
  get 'coordinates/new_zone' => 'coordinates#new_zone', :as=> 'coordinates/new_zone'
  get 'zones/clear_last_coordinate' => 'zones#clear_last_coordinate', :as=> 'zones/clear_last_coordinate'
  get 'zones/clear_coordinates' => 'zones#clear_coordinates', :as=> 'zones/clear_coordinates'
  get 'main/help' => 'main#help', :as=> 'main/help'
  get 'addresses/index_terr' => 'addresses#index_terr', :as=> 'addresses/index_terr'
  get 'addresses/home' => 'addresses#home', :as=> 'addresses/home'
  get 'addresses/new_from_street' => 'addresses#new_from_street', :as=> 'addresses/new_from_street'
  get 'addresses/export' => 'addresses#export', :as=> 'addresses/export'
  get 'addresses/what_territory' => 'addresses#what_territory', :as=> 'addresses/what_territory'
  get 'addresses/streetsearch' => 'addresses#streetsearch', :as=> 'addresses/streetsearch'
  get 'addresses/house_no_search' => 'addresses#house_no_search', :as=> 'addresses/house_no_search'
  get 'householders/home' => 'householders#home', :as=> 'householders/home'
  get 'householders/search' => 'householders#search', :as=> 'householders/search'
  get 'territories/home' => 'territories#home', :as=> 'territories/home'
  get 'addresses/index_house_number' => 'addresses#index_house_number', :as=> 'addresses/index_house_number'
  get 'addresses/index_street' => 'addresses#index_street', :as=> 'addresses/index_street'
  get 'territories/new_dynamic' => 'territories#new_dynamic', :as=> 'territories/new_dynamic'
  get 'territories/new_dynamic_centered' => 'territories#new_dynamic_centered', :as=> 'territories/new_dynamic_centered'
  get 'territories/clear_last_coordinate' => 'territories#clear_last_coordinate', :as=> 'territories/clear_last_coordinate'
  get 'territories/clear_coordinates' => 'territories#clear_coordinates', :as=> 'territories/clear_coordinates'
  get 'territories/printedque' => 'territories#printedque', :as=> 'territories/printedque'
  get 'territories/select_new_type' => 'territories#select_new_type', :as=> 'territories/select_new_type'
  get 'territories/report' => 'territories#report', :as=> 'territories/report'
  get 'territories/report_status' => 'territories#report_status', :as=> 'territories/report_status'
  get 'territories/report_cob' => 'territories#report_cob', :as=> 'territories/report_cob'
  get 'territories/report_co_date' => 'territories#report_co_date', :as=> 'territories/report_co_date'
  get 'territories/report_last_worked' => 'territories#report_last_worked', :as=> 'territories/report_last_worked'
  get 'territories/view_ter_image' => 'territories#view_ter_image', :as=> 'territories/view_ter_image'
  get 'territories/index_zone' => 'territories#index_zone', :as=> 'territories/index_zone'
  get 'territories/view_all_ter_pins_with_phones' => 'territories#view_all_ter_pins_with_phones', :as=> 'territories/view_all_ter_pins_with_phones'
  get 'territories/check_in' => 'territories#check_in', :as=> 'territories/check_in'
  get 'territories/check_out' => 'territories#check_out', :as=> 'territories/check_out'
  get 'territories/view_all_ter_pins' => 'territories#view_all_ter_pins', :as=> 'territories/view_all_ter_pins'
  get 'territories/remove_from_que' => 'territories#remove_from_que', :as=> 'territories/remove_from_que'
  get 'territories/view_ter_householders' => 'territories#view_ter_householders', :as=> 'territories/view_ter_householders'
  get 'territories/view_ter_householders_with_phones' => 'territories#view_ter_householders_with_phones', :as=> 'territories/view_ter_householders_with_phones'
  get 'territories/view_ter_householders_coords' => 'territories#view_ter_householders_coords', :as=> 'territories/view_ter_householders_coords'
  get 'territory_histories/report' => 'territory_histories#report', :as=> 'territory_histories/report'
  get 'upload/cleanup' => 'upload#cleanup', :as=> 'upload/cleanup'
  post 'territories/check_out_post' => 'territories#check_out_post', :as=> 'territories/check_out_post'
  post 'addresses/what_territory_post' => 'addresses#what_territory_post', :as=> 'addresses/what_territory_post'
  post 'login/login' => 'login#login', :as=> 'login/login'
  get 'logout' => 'login#logout', :as=> :logout
  post 'upload/uploadFile' => 'upload#uploadFile', :as=> 'upload/uploadFile'
  resources :map_layers,  only: [:update, :create, :destroy, :index]
  resources :addresses
  resources :clients
  resources :coordinates
  resources :householders,  only: [:show, :update, :create, :destroy, :index]
  resources :login
  resources :main
  resources :territories
  resources :territory_histories
  resources :upload
  resources :users
  resources :zones
  resources :territory_images





  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'login#index'

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
