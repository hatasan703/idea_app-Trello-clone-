json.extract! memo, :id, :idea_id, :user_id, :content, :position, :created_at, :updated_at
json.url company_ideas_url(memo, format: :json)