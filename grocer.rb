require 'pry'

def consolidate_cart(cart)

  products = []

  cart.each do |product|
    products << product.keys[0]
  end

  consolidated_cart = {}

  cart.each do |product|
    product.each do |item, data|
      data[:count] = products.count(item)
      consolidated_cart[item] = data
    end
  end

consolidated_cart

end

def apply_coupons(cart, coupons)

  items_in_cart = cart.keys

  coupons.each do |item_with_discount|
    binding.pry
    if items_in_cart.include?(item_with_discount[:item])
      cart["#{item_with_discount[:item]} W/COUPON"] = {
        :price => item_with_discount[:cost],
        :clearance => cart[item_with_discount[:item]][:clearance],
        :count => (cart[item_with_discount[:item]][:count]/item_with_discount[:num]).round(1)
      }
      cart[item_with_discount[:item]][:count] = cart[item_with_discount[:item]][:count] - item_with_discount[:num]
=begin
      It would make sense to add another if statement to remove items from the cart that have :count 0, after the coupons are applied.
        if cart[item_with_discount[:item]][:count] == 0
          cart.delete(item_with_discount[:item])
        end
=end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |product, data|
    if data[:clearance]
      data[:price] = (data[:price]*0.8).round(2)
    end
  end

  cart

end

def checkout(cart, coupons)
  # code here
end
