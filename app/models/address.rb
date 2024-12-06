class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :line1, :city, :postal_code, :province, presence: true
end
