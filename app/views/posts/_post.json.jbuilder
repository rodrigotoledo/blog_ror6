json.extract! post, :id, :title, :content, :likes_view, :dislikes_view, :created_at, :updated_at
json.url post_url(post, format: :json)
