class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :tenancy, optional: true
  before_create :set_default_role

  enum role: { developer: 0, admin: 1, member: 2 }

  def set_default_role
  User.count.zero? ? self.role = :developer : self.role ||= :member
  end
end
