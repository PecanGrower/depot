class LineItem < ActiveRecord::Base
  attr_accessible :product_id

  belongs_to :cart
  belongs_to :product

  validates :cart_id, presence: true
  validates :product_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  before_create :default_values

  def total_price
    price * quantity
  end

  private

    def default_values
      self.quantity ||= 1
    end
end
