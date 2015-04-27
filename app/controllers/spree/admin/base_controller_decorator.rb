Spree::Admin::BaseController.class_eval do
  def orders_list_actions
    require 'csv'
    orders_list = if params[:orders_list]
      params[:orders_list]
    else
      Spree::Order.all.pluck(:id)
    end
    orders = Spree::Order.where(id: orders_list)
    orders = orders.where(state: params[:state]) unless params[:state].empty?
    orders = orders.where(payment_state: params[:payment_state]) unless params[:payment_state].empty?
    orders = orders.where(shipment_state: params[:shipment_state]) unless params[:shipment_state].empty?

    orders = orders.order("updated_at DESC")

    # orders = Spree::Order.all
    all_orders = if orders.is_a?(Hash)
      orders.map {|k, v| v}.flatten
    else
      orders
    end
    headers = ["Order Date", "Order #", "Type", "Shipping Method", "Email", "Name", "Company", "Address 1", "Address 2", "City", "State", "Zip", "Country", "Weight (oz)", "Total Items", "Subtotal", "Handling", "Shipping", "Total", "Comments"]
    max_order_items = all_orders.map(&:line_items).map(&:size).max
    if !max_order_items.nil?
      max_order_items.times do |i|
        headers << "Item #{i+1} SKU"
        headers << "Item #{i+1} Qty"
        headers << "Item #{i+1} Attributes"
        headers << "Item #{i+1} Price"
      end



      full_csv = CSV.generate do |csv|
        csv_array = []
        csv_array << headers
        if orders.is_a?(Hash)
          orders.each do |day, v|
            csv_array << [day]
            csv_array += Spree::Order.to_csv(v, max_order_items)
          end
        else orders.is_a?(Array)
          csv_array += Spree::Order.to_csv(orders, max_order_items)
        end
        csv_array.each  do |csv_row|
          csv << csv_row
        end
      end
      send_data full_csv, :filename => 'orders.csv'
    else
      redirect_to :back
      flash[:error] = "No orders found!"
    end
  end
end
