class XhangeAuthorityToBoolean < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :authority, :integer, default: 0
    add_column :users, :authority, :boolean, default: false
  end
end
