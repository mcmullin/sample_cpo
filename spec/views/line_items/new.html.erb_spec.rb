require 'spec_helper'

describe "line_items/new" do
  before(:each) do
    assign(:line_item, stub_model(LineItem,
      :order => nil,
      :product => nil,
      :quantity => 1,
      :free => false
    ).as_new_record)
  end

  it "renders new line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", line_items_path, "post" do
      assert_select "input#line_item_order[name=?]", "line_item[order]"
      assert_select "input#line_item_product[name=?]", "line_item[product]"
      assert_select "input#line_item_quantity[name=?]", "line_item[quantity]"
      assert_select "input#line_item_free[name=?]", "line_item[free]"
    end
  end
end
