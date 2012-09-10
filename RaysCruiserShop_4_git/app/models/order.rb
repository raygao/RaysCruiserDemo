class Order < ProtectedObject
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  field :owner_id, :type => String
  field :submitted, :type => Boolean
  field :sf_cruise_order_id, :type => String # correspond to the Cruise_Order__c.ID in Salesforce

  has_many :order_items, :class_name => "OrderItem", :autosave => true, dependent: :destroy
  belongs_to :owner, :class_name => "User"       # TODO this is not working, when User is deleted.
end
