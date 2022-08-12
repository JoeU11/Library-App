class DefaultAuthorityToZero < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :authority, :integer, default: 0
  end
end
