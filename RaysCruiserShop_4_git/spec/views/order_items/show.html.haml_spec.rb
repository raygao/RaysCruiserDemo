require 'spec_helper'

describe "order_items/show" do
  before(:each) do
    @order_item = assign(:order_item, stub_model(OrderItem,
      :order_id => "Order",
      :item_id => "Item",
      :owner_id => "Owner",
      :quantity => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Order/)
    rendered.should match(/Item/)
    rendered.should match(/Owner/)
    rendered.should match(/1/)
  end
end
