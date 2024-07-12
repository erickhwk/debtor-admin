# app/serializers/report_serializer.rb
class ReportSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :files

  def content
    object.content.body.to_html
  end

  def files
    object.files.map do |file|
      {
        filename: file.filename.to_s,
        url: Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true)
      }
    end
  end
end
