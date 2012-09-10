require 'spec_helper'

describe "order_items/index" do
  before(:each) do
    assign(:order_items, [
      stub_model(OrderItem,
        :order_id => "Order",
        :item_id => "Item",
        :owner_id => "Owner",
        :quantity => 1
      ),
      stub_model(OrderItem,
        :order_id => "Order",
        :item_id => "Item",
        :owner_id => "Owner",
        :quantity => 1
      )
    ])
  end

  it "renders a list of order_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Order".to_s, :count => 2
    assert_select "tr>td", :text => "Item".to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
