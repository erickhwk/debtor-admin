class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  after_create :create_profile

  private

  def create_profile
    Rails.logger.info "Creating profile for user #{self.id}"
    role = User.count == 1 ? 'developer' : 'member'
    profile = Profile.create!(user: self, role: role)
    Rails.logger.info "Profile created with ID #{profile.id} for user #{self.id}"
  end
end
