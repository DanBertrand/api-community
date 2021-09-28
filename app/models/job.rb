class Job < ApplicationRecord
  belongs_to :community
  has_many :applies
  has_many :users, through: :applies

  validates :title, presence: true
  validates :description, presence: true
  validates :nbr_of_person_required, presence: true
  validates :duration_in_days, presence: true

  def applicants_ids
    applicants = []
    self.applies.each { |apply| applicants << apply.user_id }
    return applicants
  end

  def confirmed_applicants_ids
    applicants = []
    self.applies.each { |apply| applicants << apply.user_id }
    return applicants
  end

  def reviewed_applicants
    applicants = []
    self.applies.each { |apply| applicants << apply.user_id }
    return applicants
  end
end
