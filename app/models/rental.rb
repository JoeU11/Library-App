class Rental < ApplicationRecord
  has_many :rented_books
  belongs_to :user
end
