class OrdersController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in

  # Display a list of all past orders for the logged-in user
  def index
    @orders = current_user.orders.includes(:order_items, :books)
  end

  # Display details of a specific order
  def show
    @order = current_user.orders.includes(:order_items, :books).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Order not found."
    redirect_to orders_path
  end

  def new
    @cart = Cart.new(session)
    @order = Order.new
  end

  def create
    @cart = Cart.new(session)
    @order = Order.new(order_params)
    @order.total_price = @cart.total_price
    @order.user = current_user

    if @order.save
      # Save each cart item as an order item
      @cart.items.each do |item|
        @order.order_items.create(
          book_id: item["book_id"],
          quantity: item["quantity"],
          price: Book.find(item["book_id"]).price
        )
      end
      session[:cart] = [] # Clear the cart
      redirect_to order_path(@order), notice: "Order placed successfully."
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :province)
  end
end
