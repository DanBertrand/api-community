class UserSerializer
  include JSONAPI::Serializer

  attributes :id,
             :email,
             :first_name,
             :last_name,
             :confirmation_token,
             :confirmed_at,
             :confirmation_sent_at

  attributes :has_communities do |user|
    user.communities.length > 0 ? true : false
  end

  attributes :has_communities do |user|
    user.communities.length > 0 ? true : false
  end

  attributes :avatar do |user|
    if user.avatar
      AvatarSerializer.new(Avatar.where(user_id: user.id)[0]).serializable_hash[
        :data
      ][
        :attributes
      ]
    else
      nil
    end
  end
end
