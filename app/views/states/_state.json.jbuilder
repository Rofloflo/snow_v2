json.extract! state, :id, :state_name, :state_url, :created_at, :updated_at
json.url state_url(state, format: :json)
