class Company < ApplicationRecord
  has_many :companies_lawsuits, dependent: :destroy
  has_many :lawsuits, through: :companies_lawsuits
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', required: true

  scope :latest, -> { limit(10).reverse }
end
