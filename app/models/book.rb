class Book < ApplicationRecord
  has_many :book_categories
  has_many :categories, through: :book_categories
  belongs_to :author, optional: true
end
