json.extract! booking, :id, :car_id, :user_id, :pickup_time, :return_time, :pickup_location_id, :return_location_id, :status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
