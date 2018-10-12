json.extract! location, :id, :number, :street, :suburb, :state, :postcode, :longitude, :latitude, :created_at, :updated_at
json.url location_url(location, format: :json)
