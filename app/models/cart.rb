# app/models/cart.rb
class Cart
    def initialize(session)
      @session = session
      @session[:cart] ||= []
    end
  
    def add_item(product_id, quantity = 1)
      item = @session[:cart].find { |i| i["product_id"] == product_id }
      if item
        item["quantity"] += quantity
      else
        @session[:cart] << { "product_id" => product_id, "quantity" => quantity }
      end
    end
  
    def items
      @session[:cart]
    end
  
    def total_price
      @session[:cart].sum { |item| Product.find(item["product_id"]).price * item["quantity"] }
    end
  
    def remove_item(product_id)
      @session[:cart] = @session[:cart].reject { |item| item["product_id"] == product_id }
    end
  
    def update_quantity(product_id, quantity)
      item = @session[:cart].find { |i| i["product_id"] == product_id }
      item["quantity"] = quantity if item
    end
  end
  