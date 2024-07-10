json.extract! report, :id, :title, :lawsuit_id, :created_at, :updated_at
json.url report_url(report, format: :json)
