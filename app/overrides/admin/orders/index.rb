Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name:         'Change orders states form',
  surround: "#listing_orders",
  partial: "spree/admin/orders/order_list_actions"
)
Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name:         'Order checkboxs',
  insert_top: "[data-hook='admin_orders_index_headers']",
  text: "<th><input type='checkbox' id='all_orders' /></th>"
)

Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name:         'Order checkboxs rows',
  insert_top: "[data-hook='admin_orders_index_rows']",
  text: "<td><input type='checkbox' name='orders_list[]' value='<%=order.id%>' class='order_row'/></td>"
)
