class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_many :tenancies, through: :profile
  after_create :create_dev_profile

  def create_dev_profile
    if User.count == 1
      role ='developer'
      Profile.create(user: self, role: role)
    end
  end
end