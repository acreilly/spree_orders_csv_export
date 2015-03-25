Spree::Core::Engine.routes.draw do
  post '/shop/admin/orders_list_actions' => 'orders#orders_list_actions'
end
