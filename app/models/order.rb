class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items
  has_many :line_items, dependent: :destroy # Ensure this line exists

  # Allow searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["id", "status", "order_date", "created_at", "updated_at", "user_id"]
  end

  # Allow Ransack to search through associations
  def self.ransackable_associations(auth_object = nil)
    ["user", "order_items", "books", "line_items"]
  end
end
