class Workshop < ApplicationRecord
  belongs_to :community
  has_many :applies
  has_many :users, through: :applies

  validates :title, presence: true
  validates :description, presence: true
end
