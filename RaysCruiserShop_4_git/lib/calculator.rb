# Calculates the total of Order price, by summing up all the OrderItems
class Calculator
  def self.calculate_order_price (order_id)
     book_amount = 0
     Order.find(order_id).order_items.each do |order_item|
       book_amount = order_item.item.price * order_item.quantity + book_amount
     end
     return  book_amount
  end
end