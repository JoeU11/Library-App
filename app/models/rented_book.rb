class RentedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :rental, optional: true
end
