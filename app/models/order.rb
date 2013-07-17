class Order < ActiveRecord::Base
  attr_accessible :number, :date, :user_id, :line_items_attributes

  belongs_to :user

  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  accepts_nested_attributes_for :line_items, reject_if: lambda { |a| a[:product_id].blank? }, allow_destroy: true

  VALID_NUMBER_REGEX = /\A\d{8}\z/
  validates :number, presence: true, format: { with: VALID_NUMBER_REGEX }, uniqueness: { case_sensitive: false }
  #validates :date, presence: true
  validates :user_id, presence: true
end
