class Community < ApplicationRecord
  has_many :members
  has_many :users, through: :members
  geocoded_by :address
  after_validation :geocode
end
