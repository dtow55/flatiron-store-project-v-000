class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total 
    total = 0
    self.line_items.each { |line_item| total += (Item.find(line_item.item_id).price * line_item.quantity) }
    total
  end
  
  def add_item(item_id)
    item_id = item_id.to_i
    if item_ids.include?(item_id)
      line_items.find_by(item_id: item_id).increment
    else
      line_items.build(cart_id: self.id, item_id: item_id)
    end
  end

  def checkout
    self.update(status: "submitted")
    line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      item.update(inventory: item.inventory - line_item.quantity)
    end
  end
end
