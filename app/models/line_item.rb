class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  def increment
    self.quantity += 1
    self
  end
end
