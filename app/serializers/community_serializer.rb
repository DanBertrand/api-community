class CommunitySerializer
  include JSONAPI::Serializer
  
  attributes :id, :name, :address, :description, :members, :created_at, :updated_at


  # attributes :creator do |object|
  #   object.user
  # end

end
