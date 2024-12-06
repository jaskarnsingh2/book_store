class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :categories
  has_many :order_items, dependent: :destroy
  has_one_attached :image

  # Validations
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "author_id", "genre", "price", "stock", "created_at", "updated_at"]
  end

  # Ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["author", "categories", "order_items", "image_attachment"]
  end
end
