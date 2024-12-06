# frozen_string_literal: true

class AddDeviseToAdminUsers < ActiveRecord::Migration[7.2]
  def self.up
    change_table :admin_users do |t|
      # Add email column only if it does not already exist
      unless column_exists?(:admin_users, :email)
        t.string :email, null: false, default: ""
      end

      # Add encrypted_password column if it doesn't exist
      unless column_exists?(:admin_users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      # Add other necessary columns similarly...
      unless column_exists?(:admin_users, :reset_password_token)
        t.string :reset_password_token
      end
      unless column_exists?(:admin_users, :reset_password_sent_at)
        t.datetime :reset_password_sent_at
      end
      unless column_exists?(:admin_users, :remember_created_at)
        t.datetime :remember_created_at
      end
    end

    # Add indices if not already present
    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
