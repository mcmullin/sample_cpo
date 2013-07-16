class Order < ActiveRecord::Base
  attr_accessible :date, :number, :user_id, :line_items_attributes

  belongs_to :user

  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  accepts_nested_attributes_for :line_items, reject_if: lambda { |a| a[:product_id].blank? }, allow_destroy: true
end
