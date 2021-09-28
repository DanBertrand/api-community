class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  # Include default devise modules. Others available are: :omniauthable,:lockable, :timeoutable, :trackable,

  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  # after_create :send_confirmation_email

  validates :email, presence: true
  validates_uniqueness_of :email
  validates :password, presence: true

  has_many :members
  has_many :applies, as: :applyable
  has_many :jobs, through: :applies
  has_many :workshops, through: :applies

  has_one :avatar
  has_many :communities, through: :members
  has_one :address, as: :addressable

  def communities_with_member_info
    communities = []
    self.members.each do |member|
      community = Community.find(member.community_id).serializable_hash
      community[:user_infos] = { member_id: member.id, role: member.role }
      communities << community
    end
    return communities
  end

  def apply(item)
    return item.users << self ? true : item.errors.messages
  end

  private

  # def send_confirmation_email
  #   UserMailer.confirmation_email(self).deliver_now
  # end
end
