class CommunitySerializer
  include JSONAPI::Serializer
  
  attributes :id, :name, :address, :description, :created_at, :updated_at, :users
  
  attributes :creator_id do |object|
    object.members.where(role:"creator")[0].id
  end
  attributes :members_count do |object|
    object.members.length
  end


  attributes :members, :latitude, :longitude



end
