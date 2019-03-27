def consolidate_cart(cart)
  final_cart = {}
  cart.each do |element|
    element.each do |fruit, hash|
      final_cart[fruit] ||= hash
      final_cart[fruit][:count] ||= 0
      final_cart[fruit][:count] += 1
    end
  end
  return final_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    # Create variable item, as the name of the discounted 'fruit'
    item = coupon_hash[:item]
    # If the discounted item exists and also there is enough
    # to be reduced create a temporary item
    if cart[item] && cart[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => cart[item][:clearance],
        :count => 1
        }
      }
    # If there isnt a discounter item merge the arrays else add 1 to the count
      if cart["#{item} W/COUPON"].nil?
        cart.merge!(temp)
      else
        cart["#{item} W/COUPON"][:count] += 1

      end
    # Reduced the amount of the original item by the discounted amount
      cart[item][:count] -= coupon_hash[:num]
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  total_1 = consolidate_cart(cart)
  total_2 = apply_coupons(total_1, coupons)
  total_3 = apply_clearance(total_2)

  price = 0

  total_3.each do |name, price_hash|
    price += price_hash[:price] * price_hash[:count]
  end

  # Ternary operator 'if x > y do a else b'
  price > 100 ? price * 0.9 : price

end
