class SimplifyStock < ActiveRecord::Migration[7.0]
  def change
    rename_column :books, :total_stock, :stock
  end
end
