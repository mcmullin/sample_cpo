require 'spec_helper'

describe "line_items/index" do
  before(:each) do
    assign(:line_items, [
      stub_model(LineItem,
        :order => nil,
        :product => nil,
        :quantity => 1,
        :free => false
      ),
      stub_model(LineItem,
        :order => nil,
        :product => nil,
        :quantity => 1,
        :free => false
      )
    ])
  end

  it "renders a list of line_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
