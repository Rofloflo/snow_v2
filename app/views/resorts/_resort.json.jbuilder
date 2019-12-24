json.extract! resort, :id, :resort_name, :resort_url, :recent_time, :recent_snowfall, :next_snowfall, :next5_snowfall, :state_id, :created_at, :updated_at
json.url resort_url(resort, format: :json)
