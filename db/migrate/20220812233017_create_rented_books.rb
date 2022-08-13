class CreateRentedBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :rented_books do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :rental_id
      t.datetime :due_date
      t.string :status

      t.timestamps
    end
  end
end
