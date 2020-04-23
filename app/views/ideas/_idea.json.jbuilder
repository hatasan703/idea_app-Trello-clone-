json.extract! idea, :id, :title, :content, :position, :open, :created_at, :updated_at, :user_id, :company_id, :memos
json.url company_ideas_url(idea, format: :json)