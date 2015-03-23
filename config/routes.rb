Spree::Core::Engine.routes.draw do
  post '/admin/orders_list_actions' => 'spree/orders#orders_list_actions'
end
