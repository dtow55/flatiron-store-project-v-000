class StoreController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.available_items
    @cart = current_cart
  end
end
