json.extract! comment, :id, :idea_id, :user_id, :content, :created_at, :updated_at
json.url public_ideas_url(comment, format: :json)
