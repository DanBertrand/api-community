class Member < ApplicationRecord
  belongs_to :user
  belongs_to :community
  validates :user, presence: true
  validates :community, presence: true
  validates :role, presence: true
end
