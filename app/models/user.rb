class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::Allowlist
  devise :database_authenticatable, :registerable,
  :jwt_authenticatable, jwt_revocation_strategy: self

         validates :email, presence: true
         validates_uniqueness_of :email
         validates :password, presence: true
end
