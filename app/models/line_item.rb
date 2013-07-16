class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  attr_accessible :free, :quantity, :order_id, :product_id
end
