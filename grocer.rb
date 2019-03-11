def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |name, attributes|
      result[name] ||= attributes
      result[name][:count] ||= 0
      result[name][:count] += 1
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    
    if cart[item_name] && cart[item_name][:count] >= coupon[:num]
      item_name_with_coupon = "#{item_name} W/COUPON"
    
      if cart[item_name_with_coupon]
        cart[item_name_with_coupon][:count] += 1
      else
        cart[item_name_with_coupon] = {}
        cart[item_name_with_coupon][:price] = coupon[:cost]
        cart[item_name_with_coupon][:clearance] = cart[item_name][:clearance]
        cart[item_name_with_coupon][:count] = 1
      end
      
      cart[item_name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, data|
    data[:price] = (data[:price] * 0.8).round(2) if data[:clearance]
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  sum = 0
  cart.each do |item, item_data|
    sum += item_data[:count] * item_data[:price]
  end

  sum > 100 ? (sum * 0.9).round(2) : sum
end
