class RentedBook < ApplicationRecord
  belongs_to :user
  belongs_to :books
  belongs_to :rentals, optional: true
end
