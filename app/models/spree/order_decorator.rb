Spree::Order.class_eval do
  def self.to_csv(orders, max_order_items)
    csv = []
    orders.each do |order|
      row = [order.completed_at.try(:strftime, "%m/%d/%Y"), order.number, "Donation", order.shipments.map(&:shipping_method).map(&:name).uniq.join(", "), order.email, order.name, order.shipping_address.try(:company), order.shipping_address.try(:address1), order.shipping_address.try(:address2), order.shipping_address.try(:city), order.shipping_address.try(:state).try(:name), order.shipping_address.try(:zipcode), order.shipping_address.try(:country).try(:name), "0", order.line_items.count, order.item_total.to_s, order.shipments.map(&:cost).sum.to_s, order.shipments.map(&:cost).sum.to_s, nil] # TODO Comments
      order.line_items.each do |li|
        row << li.sku
        row << li.quantity
        row << nil #TODO Attributes
        row << li.price.to_s
      end
      remaining_items = max_order_items - order.line_items.count
      row << [""] * remaining_items * 4

      csv << row.flatten
    end
    csv
  end
end