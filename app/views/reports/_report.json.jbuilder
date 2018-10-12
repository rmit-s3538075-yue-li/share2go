json.extract! report, :id, :user_id, :booking_id, :content, :created_at, :updated_at
json.url report_url(report, format: :json)
