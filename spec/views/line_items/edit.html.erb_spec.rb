require 'spec_helper'

describe "line_items/edit" do
  before(:each) do
    @line_item = assign(:line_item, stub_model(LineItem,
      :order => nil,
      :product => nil,
      :quantity => 1,
      :free => false
    ))
  end

  it "renders the edit line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", line_item_path(@line_item), "post" do
      assert_select "input#line_item_order[name=?]", "line_item[order]"
      assert_select "input#line_item_product[name=?]", "line_item[product]"
      assert_select "input#line_item_quantity[name=?]", "line_item[quantity]"
      assert_select "input#line_item_free[name=?]", "line_item[free]"
    end
  end
end
