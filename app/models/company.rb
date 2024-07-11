class Company < ApplicationRecord
  has_and_belongs_to_many :lawsuits
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', required: true

  scope :latest, -> { limit(10).reverse }
end
