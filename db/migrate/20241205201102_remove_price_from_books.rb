class RemovePriceFromBooks < ActiveRecord::Migration[7.2]
  def change
    remove_column :books, :price, :decimal
  end
end
