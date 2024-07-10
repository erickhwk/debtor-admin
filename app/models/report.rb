class Report < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', required: true
  belongs_to :lawsuit
  has_rich_text :content
  has_many_attached :files
end
