require 'spec_helper'

describe "order_items/edit" do
  before(:each) do
    @order_item = assign(:order_item, stub_model(OrderItem,
      :order_id => "MyString",
      :item_id => "MyString",
      :owner_id => "MyString",
      :quantity => 1
    ))
  end

  it "renders the edit order_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => order_items_path(@order_item), :method => "post" do
      assert_select "input#order_item_order_id", :name => "order_item[order_id]"
      assert_select "input#order_item_item_id", :name => "order_item[item_id]"
      assert_select "input#order_item_owner_id", :name => "order_item[owner_id]"
      assert_select "input#order_item_quantity", :name => "order_item[quantity]"
    end
  end
end
