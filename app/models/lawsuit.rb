class Lawsuit < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', required: true
  belongs_to :tenancy
  has_many :reports, dependent: :destroy
  has_many :companies_lawsuits, dependent: :destroy
  has_many :companies, through: :companies_lawsuits

  enum category: { bankruptcy: 0, judicial_recovery: 1 }

  scope :latest, -> { limit(10).reverse }
end
