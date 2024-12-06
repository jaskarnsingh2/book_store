class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
    @orders = @user.orders.includes(:order_items, :products) # Adjust associations as needed
  end
end
