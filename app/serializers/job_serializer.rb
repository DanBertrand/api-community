class JobSerializer
  include JSONAPI::Serializer

  attributes :id,
             :title,
             :description,
             :duration_in_days,
             :nbr_of_person_required

  attributes :applicants_ids do |job|
    job.applicants_ids
  end

  attributes :confirmed_applicants do |job|
    job.applicants_ids
  end

  attributes :unconfirmed_applicants do |job|
    job.applicants_ids
  end
end
