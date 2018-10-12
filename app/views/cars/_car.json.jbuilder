json.extract! car, :id, :image, :make, :year, :model, :body_type, :number_plate, :condition, :price, :status, :created_at, :updated_at
json.url car_url(car, format: :json)
