class Community < ApplicationRecord
  has_many :members
  has_many :users, through: :community_members
  has_many :workshops
  has_many :jobs
  has_one :address, as: :addressable

  # scope :creator, -> { where(role: 'creator') }

  def add_address(params)
    self.address =
      Address.create(
        formatted_address: params[:formatted_address],
        house_number: params[:house_number],
        street: params[:street],
        post_code: params[:post_code],
        country: params[:country],
        state: params[:state],
        city: params[:city],
        longitude: params[:longitude],
        latitude: params[:latitude],
      )
  end

  def add_creator(user)
    creator = Member.create(community: self, user: user, role: 'creator')
    self.members << creator
  end
end
