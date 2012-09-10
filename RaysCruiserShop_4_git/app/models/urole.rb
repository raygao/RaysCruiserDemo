class Urole
  include Mongoid::Document
  store_in collection: "user_roles"
  field :name, :type => String
  field :description, :type => String
  has_many :users, :class_name => "User"
  validates_uniqueness_of :name       #role name are unique.
end
