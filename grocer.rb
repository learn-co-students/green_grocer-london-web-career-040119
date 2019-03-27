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
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
