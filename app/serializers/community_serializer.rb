class CommunitySerializer
  include JSONAPI::Serializer

  attributes :id, :name, :description, :created_at, :updated_at

  attributes :address do |object|
    object.address
  end

  # attributes :members_count do |object|
  #   object.members.length
  # end

  attributes :is_admin do |object, params|
    # binding.pry
    if params[:current_user] && params[:current_user].id
      if object.members.find(user_id = params[:current_user].id).role ===
           ('creator' || 'moderator')
        true
      else
        false
      end
    else
      false
    end
  end

  # attributes :creator do |object|
  #   object.creator
  # end

  # attributes :moderators do |object|
  #   object.moderators_members
  # end

  # attributes :members do |object|
  #   object.basic_members
  # end

  attributes :has_workshops do |object|
    object.workshops.length > 0
  end

  attributes :has_jobs do |object|
    object.jobs.length > 0
  end
end
