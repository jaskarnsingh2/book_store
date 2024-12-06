class CartsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated before checkout

  def add_to_cart
    book = Book.find(params[:book_id]) # Ensure you're using the Book model to find the book

    session[:cart] ||= []
    existing_item = session[:cart].find { |item| item["book_id"] == book.id }

    if existing_item
      existing_item["quantity"] += 1
    else
      session[:cart] << { "book_id" => book.id, "quantity" => 1, "price" => book.price }
    end

    redirect_to cart_path
  end

  # Update action for updating the quantity of items in the cart
  def update
    session[:cart] ||= []

    book_id = params[:book_id].to_i
    new_quantity = params[:quantity].to_i
    item = session[:cart].find { |item| item["book_id"] == book_id }

    if item
      if new_quantity > 0
        item["quantity"] = new_quantity
        flash[:notice] = "Quantity updated successfully."
      else
        session[:cart].delete(item)
        flash[:alert] = "Item removed from the cart."
      end
    else
      flash[:alert] = "Item not found in the cart."
    end

    redirect_to cart_path
  end

  def show
    session[:cart] ||= [] # Ensure the cart is initialized
    @cart_items = []

    session[:cart].each do |item|
      book = Book.find_by(id: item["book_id"])
      if book
        @cart_items << {
          id: book.id,
          title: book.title,
          author_name: book.author.name,
          price: book.price,
          quantity: item["quantity"],
          total_price: item["quantity"] * book.price
        }
      end
    end
  end

  def remove
    session[:cart] ||= []
    session[:cart].reject! { |item| item["book_id"] == params[:book_id].to_i }
    redirect_to cart_path
  end

  def checkout
    @cart = session[:cart] || [] # Initialize @cart to an empty array if session[:cart] is nil
    @tax_rate = calculate_tax_rate(current_user.province) # Tax rate based on province
    @total_price = calculate_total_price(@cart, @tax_rate)
  end

  def process_checkout
    @total_price = calculate_total_price(session[:cart], calculate_tax_rate(current_user.province))
    @order = Order.create(user: current_user, total_price: @total_price, tax_rate: calculate_tax_rate(current_user.province))

    # Create order items from session cart
    session[:cart].each do |item|
      @order.order_items.create(book_id: item["book_id"], quantity: item["quantity"])
    end

    # Save address if not already saved
    if current_user.address.nil?
      current_user.create_address(address_params)
    end

    # Clear cart
    session[:cart] = []

    redirect_to thank_you_path
  end

  private

  # Calculate tax rate based on user's province
  def calculate_tax_rate(province)
    case province.name
    when "Ontario"
      0.13 # HST
    when "Quebec"
      0.14 # GST + QST
    else
      0.12 # Default tax rate for other provinces
    end
  end

  # Calculate total price of the items in the cart, including tax
  def calculate_total_price(cart, tax_rate)
    subtotal = cart.sum do |item|
      price = item["price"].to_f # Convert to Float
      quantity = item["quantity"].to_i # Convert to Integer
      price * quantity
    end
    total_price = subtotal + (subtotal * tax_rate) # Apply tax rate
    total_price.round(2) # Round to 2 decimal places for currency
  end

  # Strong parameters for address
  def address_params
    params.require(:address).permit(:line1, :city, :postal_code)
  end
end
