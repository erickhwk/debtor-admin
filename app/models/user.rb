class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :tenancies, through: :profile
  after_create :create_profile

  def create_profile
    User.count == 1 ? role = 'developer' : role = 'member'
    Profile.create(user: self, role: role)
  end
end