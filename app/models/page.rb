class Page < ApplicationRecord
    # Explicitly allowlist searchable attributes for Ransack
    def self.ransackable_attributes(auth_object = nil)
      ["title", "content", "created_at", "updated_at"]
    end
  
    # Optional: If you have associations, define ransackable associations
    def self.ransackable_associations(auth_object = nil)
      [] # Empty array as there are no associations
    end
  end
  