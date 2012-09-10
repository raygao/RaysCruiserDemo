class OrderItem < ProtectedObject
  include Mongoid::Document
  field :order_id, :type => String
  field :item_id, :type => String
  field :owner_id, :type => String
  field :note, :type => String
  field :quantity, :type => Integer

  belongs_to :order
  belongs_to :item
  belongs_to :owner, :class_name => "User"  # TODO this is not working, when User is deleted.

  validates :item_id, presence: true
  validates :owner_id, presence: true
  validates :quantity, presence: true

  # Before add a new OrderItem, check to see if enough Item quantity exists
  before_create do
    current_item_quantity =  self.item.quantity
    remove_quantity = self.quantity
    unless (current_item_quantity - remove_quantity) < 0
       self.item.update_attributes!(quantity: (current_item_quantity - remove_quantity) )
    else
      raise "Cannot remove more than available quantity from #{self.item.name}."
    end
  end

  # Change Quantity
  before_update do
    # http://stackoverflow.com/questions/3861777/determine-what-attributes-were-changed-in-rails-after-save-callback
    # http://mongoid.org/en/mongoid/docs/callbacks.html
    self.changed.each do |column|
      if (column == 'quantity')
        current_item_quantity = self.item.quantity

        old_quantity = self.changes[column][0]
        new_quantity = self.changes[column][1]

        unless (current_item_quantity - new_quantity) < 0
           self.item.update_attributes!(quantity: (current_item_quantity - new_quantity + old_quantity) )
        else
          raise "Cannot remove more than available quantity from #{self.item.name}."
        end
      end
    end

  end


  # After deleting an OrderItem, make it again available to Item
  after_destroy do
    self.item.update_attributes!(quantity: (self.item.quantity + self.quantity) )
    puts 'blah'
  end


end
