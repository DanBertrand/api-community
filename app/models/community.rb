class Community < ApplicationRecord
  has_many :members
  has_many :users, through: :members
end
