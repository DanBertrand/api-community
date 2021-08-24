class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :first_name, :last_name

  attributes :has_communities do |user|
    user.communities.length > 0 ? true : false
  end

  attributes :avatar do |user|
    user.avatar ? {id: user.avatar.id, url: user.avatar.url, public_id: user.avatar.public_id} : nil
  end



end
