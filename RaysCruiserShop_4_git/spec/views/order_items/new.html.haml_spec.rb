require 'spec_helper'

describe "order_items/new" do
  before(:each) do
    assign(:order_item, stub_model(OrderItem,
      :order_id => "MyString",
      :item_id => "MyString",
      :owner_id => "MyString",
      :quantity => 1
    ).as_new_record)
  end

  it "renders new order_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => order_items_path, :method => "post" do
      assert_select "input#order_item_order_id", :name => "order_item[order_id]"
      assert_select "input#order_item_item_id", :name => "order_item[item_id]"
      assert_select "input#order_item_owner_id", :name => "order_item[owner_id]"
      assert_select "input#order_item_quantity", :name => "order_item[quantity]"
    end
  end
end
