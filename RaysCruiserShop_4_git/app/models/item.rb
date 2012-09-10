class Item  < ProtectedObject
  include Mongoid::Document
  require 'carrierwave/mongoid'

  field :name, :type => String
  field :image, :type => String
  field :description, :type => String
  field :item_type_id, :type => String
  field :price, :type => Float
  field :quantity, :type => Integer

  # Using Carrierwave to manage image, see /app/uploads/image_uploader.rb
  mount_uploader :image, ImageUploader

  belongs_to :item_type
end
