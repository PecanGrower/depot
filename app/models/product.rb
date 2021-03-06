class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :title, :price

  has_many :line_items
  has_many :orders, through: :line_items

  validates :title, length: { minimum: 10 }, uniqueness: true
  validates :description, presence: true
  validates :image_url, format: { with: /\w+\.(jpg|gif|png)$/i }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }


  before_destroy :ensure_not_referenced_by_any_line_item

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        true
      else
        errors.add(:base, 'Line Items present')
        false
      end
    end


end
