class Category < ApplicationRecord
    has_and_belongs_to_many :books
  
    validates :name, presence: true, uniqueness: true
  
    # Allow Ransack to search through associations
    def self.ransackable_associations(auth_object = nil)
      ["books"]
    end
  
    # Optionally, define ransackable attributes if needed
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "created_at", "updated_at"]
    end
  end
  