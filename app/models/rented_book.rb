class RentedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :rentals, optional: true
end
