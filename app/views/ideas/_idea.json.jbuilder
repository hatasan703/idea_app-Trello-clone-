json.extract! idea, :id, :title, :content, :position, :created_at, :updated_at, :user_id, :memos
json.url idea_url(idea, format: :json)
