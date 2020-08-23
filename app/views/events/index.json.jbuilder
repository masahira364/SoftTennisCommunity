json.array!(@events) do |event|
	json.extract! event, :id, :title, :description, :team_id
	json.title event.title
	json.start event.start_date
	json.end event.end_date
	json.url event_url(event, team_id: event.team_id)
end