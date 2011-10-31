class CombineItemsInCart < ActiveRecord::Migration
  def up
    @carts = Cart.all
    @carts.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(:product_id => product_id).delete_all
          cart.line_items.build(:product_id => product_id, :quantity => quantity)
        end
      end

    end
  end

  def down
  end
end
