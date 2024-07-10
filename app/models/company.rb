class Company < ApplicationRecord
  has_and_belongs_to_many :lawsuits

  scope :latest, -> { limit(10).reverse }
end
