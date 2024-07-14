class CompaniesLawsuit < ApplicationRecord
  belongs_to :company
  belongs_to :lawsuit
end
