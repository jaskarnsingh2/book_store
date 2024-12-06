class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["books"] # List only valid associations for Ransack
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "biography", "created_at", "updated_at"] # Allow valid attributes for filtering
  end
end
