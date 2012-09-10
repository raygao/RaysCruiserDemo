require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :name => "MyString",
      :description => "MyText",
      :owner_id => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path(@order), :method => "post" do
      assert_select "input#order_name", :name => "order[name]"
      assert_select "textarea#order_description", :name => "order[description]"
      assert_select "input#order_owner_id", :name => "order[owner_id]"
    end
  end
end
