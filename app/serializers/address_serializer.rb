class AddressSerializer
  include JSONAPI::Serializer

  attributes :id,
             :formatted_address,
             :house_number,
             :street,
             :post_code,
             :state,
             :city,
             :latitude,
             :longitude
end
