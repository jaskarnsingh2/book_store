class User < ApplicationRecord
  belongs_to :province
  has_one :address
  has_many :orders
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Add roles if needed
  enum role: { customer: 0, admin: 1 } # Define roles as needed
  after_initialize :set_default_role, if: :new_record?

  # Permit the username attribute during Devise registration
  attr_accessor :username # Allow Devise to handle username during registration

  # Ensure username is set correctly
  validates :username, presence: true, uniqueness: true  # Validate presence and uniqueness of username

  private

  def set_default_role
    self.role ||= :customer
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "created_at", "updated_at", "username"]  # Add username to ransackable attributes
  end
end
