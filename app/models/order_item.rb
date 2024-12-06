# app/models/order_item.rb
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  validates :quantity, presence: true
  # Explicitly allowlist searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "id", "order_id", "price_at_purchase", "quantity", "updated_at"]
  end

  # Allow Ransack to search through associations (if needed)
  def self.ransackable_associations(auth_object = nil)
    ["order", "book"]
  end
end
