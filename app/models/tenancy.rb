class Tenancy < ApplicationRecord
  has_many :users
  has_many :lawsuits
end
