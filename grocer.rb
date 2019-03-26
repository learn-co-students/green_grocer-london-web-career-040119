require "pry"

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |k, v|
      v[:count] = cart.count(item)
      cart_hash[k] = v
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |hash|
    x = hash[:item]
    if cart[x] && cart[x][:count] >= hash[:num]
      if !cart["#{x} W/COUPON"]
        cart["#{x} W/COUPON"] = {:count => 1, :price => hash[:cost]}
        cart["#{x} W/COUPON"][:clearance] = cart[x][:clearance]
      else
        cart["#{x} W/COUPON"][:count] += 1
      end
      cart[x][:count] -= hash[:num]
    end
  end
  cart
end

def apply_clearance(cart)
    cart.each do |item, value|
    if value[:clearance]
      value[:price] = (value[:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item, info|
    total += (info[:count]).to_f * info[:price]
  end
  if total > 100
    total = total * 0.90
  end
  total
end