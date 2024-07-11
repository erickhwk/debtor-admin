class Tenancy < ApplicationRecord
  has_many :lawsuits
  has_many :profiles
  has_many :users, through: :profiles
end
