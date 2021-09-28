class WorkshopSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description
end
