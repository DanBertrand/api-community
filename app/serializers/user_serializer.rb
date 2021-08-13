class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email

  attributes :has_communities do |user|
    user.communities.length > 0 ? true : false
  end

end
