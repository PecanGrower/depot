class Cart < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :line_items, dependent: :destroy

  def add_product(product)
    if line_items.find_by_product_id(product.id)
      line_item = line_items.find_by_product_id(product.id)
      line_item.quantity += 1
      return line_item
    else
      line_item = line_items.build(product_id: product.id)
      line_item.price = product.price
      return line_item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
