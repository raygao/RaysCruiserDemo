require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :name => "Header",
      :image => "Image",
      :description => "Description",
      :item_type_id => "Item Type",
      :align => "Align",
      :owner_id => "Owner"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Header/)
    rendered.should match(/Image/)
    rendered.should match(/Description/)
    rendered.should match(/Item Type/)
    rendered.should match(/Align/)
    rendered.should match(/Owner/)
  end
end
