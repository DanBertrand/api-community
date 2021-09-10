class AvatarSerializer
  include JSONAPI::Serializer

  attributes :id, :url, :public_id
end
