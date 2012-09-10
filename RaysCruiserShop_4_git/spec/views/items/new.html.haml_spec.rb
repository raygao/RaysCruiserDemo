require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :name => "MyString",
      :image => "MyString",
      :description => "MyString",
      :item_type_id => "MyString",
      :align => "MyString",
      :owner_id => "MyString"
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_header", :name => "item[header]"
      assert_select "input#item_image", :name => "item[image]"
      assert_select "input#item_description", :name => "item[description]"
      assert_select "input#item_item_type_id", :name => "item[item_type_id]"
      assert_select "input#item_align", :name => "item[align]"
      assert_select "input#item_owner_id", :name => "item[owner_id]"
    end
  end
end
