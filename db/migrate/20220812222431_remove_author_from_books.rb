class RemoveAuthorFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :author 
    add_column :books, :author_id, :integer
  end
end
