Spree::Core::Engine.routes.draw do
  post '/admin/orders_list_actions' => 'orders#orders_list_actions', as: :orders_list_actions
end
