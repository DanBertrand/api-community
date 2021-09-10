class Community < ApplicationRecord
  has_many :members
  has_many :users, through: :members
  has_one :address, as: :addressable


  def creator
    member = Member.where(community_id: self.id, role:"creator")[0]
    user = UserSerializer.new(User.find(member[:user_id])).serializable_hash[:data][:attributes]
    user[:member_id] = member[:id]
    return user
  end

  def basic_members
    members = []
    Member.where(community_id: self.id, role:"basic").each do |member|
      user = UserSerializer.new(User.find(member[:user_id])).serializable_hash[:data][:attributes]
      user[:member_id] = member[:id]
      members << user
    end
    return members
  end

  def moderators_members
    members = []
    Member.where(community_id: self.id, role:"moderator").each do |member|
      user = UserSerializer.new(User.find(member[:user_id])).serializable_hash[:data][:attributes]
      user[:member_id] = member[:id]
      members << user
    end
    return members
  end



end
