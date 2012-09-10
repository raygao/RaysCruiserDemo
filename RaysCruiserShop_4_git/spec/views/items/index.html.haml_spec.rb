require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :name => "Header",
        :image => "Image",
        :description => "Description",
        :item_type_id => "Item Type",
        :align => "Align",
        :owner_id => "Owner"
      ),
      stub_model(Item,
        :name => "Header",
        :image => "Image",
        :description => "Description",
        :item_type_id => "Item Type",
        :align => "Align",
        :owner_id => "Owner"
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Header".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Item Type".to_s, :count => 2
    assert_select "tr>td", :text => "Align".to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
  end
end
