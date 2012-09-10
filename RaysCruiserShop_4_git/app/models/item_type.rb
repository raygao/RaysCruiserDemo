class ItemType
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  has_many :items, :class_name => "Item", :autosave => true, dependent: :destroy

  validates :name, presence: true
end
