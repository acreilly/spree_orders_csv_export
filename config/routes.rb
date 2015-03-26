Spree::Core::Engine.routes.draw do
  namespace :admin do
    post '/orders_list_actions' => 'orders#orders_list_actions'
  end
end
