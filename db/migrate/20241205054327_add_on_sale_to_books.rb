class AddOnSaleToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :on_sale, :boolean
  end
end
