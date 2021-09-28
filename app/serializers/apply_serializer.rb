class ApplySerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :validated
end
