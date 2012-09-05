class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :title, :price

  validates :title, length: { minimum: 10 }, uniqueness: true
  validates :description, presence: true
  validates :image_url, format: { with: /\w+\.(jpg|gif|png)$/i }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

end
