class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :tenancy, optional: true

  enum role: { developer: 0, admin: 1, member: 2 }
end
