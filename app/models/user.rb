class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::Allowlist
  devise :database_authenticatable, :registerable,
  :jwt_authenticatable, jwt_revocation_strategy: self

         validates :email, presence: true
         validates_uniqueness_of :email
         validates :password, presence: true

  has_many :members
  has_many :communities, through: :members

  def communities_creator
    communities = []
    self.members.where(role:"creator").each do |creator|
      communities << Community.find(creator.community_id)
    end
    return communities.length > 0 && communities 
  end

  def communities_member
    communities = []
    self.members.where(role:"basic").each do |basic_member|
      communities << Community.find(basic_member.community_id)
    end
    return communities.length > 0 && communities
  end

  # def formatted_communities
  #   case 
  #   when self.communities_creator && self.communities_member
  #     return {creator: self.communities_creator, member: self.communities_member}
  #   when !self.communities_creator && self.communities_member
  #     return {member: self.communities_member}
  #   when self.communities_creator && !self.communities_member
  #     return {creator: self.communities_creator}
  #   else
  #     return nil
  #   end
  # end

end
