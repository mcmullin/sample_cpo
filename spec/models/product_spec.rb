require 'spec_helper'

describe Product do

  before { @product = Product.new(item: "1000R", description: "fake knife", retail: "100", cpo: "90", points: "75", category: "none") }

  subject { @product }

  it { should respond_to(:item) }
  it { should respond_to(:description) }
  it { should respond_to(:retail) }
  it { should respond_to(:cpo) }
  it { should respond_to(:points) }
  it { should respond_to(:category) }

  it { should be_valid }

  describe "when item is not present" do
    before { @product.item = " " }
    it { should_not be_valid }
  end

  describe "when item is nil" do
  	before { @product.item = nil }
  	it { should_not be_valid }
	end

  describe "when item number is invalid" do
    it "should be invalid" do
      items = %w[100G 200H-1Z 1 10000 1000r]
      items.each do |invalid_item|
        @product.item = invalid_item
        @product.should_not be_valid
      end      
    end
  end

  describe "when item number is valid" do
    it "should be valid" do
      items = %w[1000WRB 81 777-1 100H-2 5000DBDD-2]
      items.each do |valid_item|
        @product.item = valid_item
        @product.should be_valid
      end      
    end
  end

  describe "when item number is already taken" do
    before do
      product_with_same_item = @product.dup
      product_with_same_item.item = @product.item.upcase
      product_with_same_item.save
    end

    it { should_not be_valid }
  end

  describe "when description is not present" do
  	before { @product.description = " " }
  	it { should_not be_valid }
	end

	describe "when description is nil" do
  	before { @product.description = nil }
  	it { should_not be_valid }
	end

	# numericality

end