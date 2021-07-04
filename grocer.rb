def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |item|
    item.each do |name, info|
      if hash[name]
         hash[name][:count] += 1 
         
       else
         hash[name] = info
         hash[name][:count] = 1
         
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}
  cart.each do |grocery, item|
    coupons.each do |coupon|
      if grocery == coupon[:item] && item[:count] >= coupon[:num]
        cart[grocery][:count] = cart[grocery][:count] - coupon[:num]
        if new_cart[grocery + " W/COUPON"]
          new_cart[grocery + " W/COUPON"][:count] += 1
        else
          new_cart[grocery + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[grocery][:clearance], :count => 1}
        end
      end
    end
    new_cart[grocery] = item

  end
  new_cart
end

def apply_clearance(cart)
  # code here
  new_cart = {}
  
  cart.each do |grocery, info|
    new_cart[grocery] = {}
    info.each do |data|
      if cart[grocery][:clearance]
        new_cart[grocery][:price] = (cart[grocery][:price] * 0.80).round(2)
        
      else
        new_cart[grocery][:price] = cart[grocery][:price]
      end
    new_cart[grocery][:clearance] = cart[grocery][:clearance]
    new_cart[grocery][:count] = cart[grocery][:count]
    end
  end
  new_cart
end

def checkout(cart: [], coupons: [])
  # code here
  cart_total = 0
 
  cart = consolidate_cart(cart: cart)
  cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)
  
  cart.each do |grocery, info|
    cart_total += (info[:price] * info[:count]).to_f
  end
  
  if cart_total > 100
    cart_total* 0.90.round(2)
  end
 cart_total
end
