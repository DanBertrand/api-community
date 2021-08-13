class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email

  attributes :has_communities do |user|
    user.communities.length > 0 ? true : false
  end

#   attribute :communities, if: Proc.new { |user|
#   user.formatted_communities
# }  do |user|
#     user.formatted_communities
#   end
  
end
