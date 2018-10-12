json.extract! user, :id, :first_name, :last_name, :license_no, :mobile, :email, :credit_card_no, :created_at, :updated_at
json.url user_url(user, format: :json)
