class LineItem < ActiveRecord::Base
  attr_accessible :product_id

  belongs_to :cart
  belongs_to :product

  validates :cart_id, presence: true
  validates :product_id, presence: true
end
