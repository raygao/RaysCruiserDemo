# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    order_id "MyString"
    item_id "MyString"
    duration "MyString"
    order "MyString"
  end
end
