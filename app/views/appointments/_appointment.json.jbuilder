json.extract! appointment, :id, :hour, :duration, :description, :user_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
