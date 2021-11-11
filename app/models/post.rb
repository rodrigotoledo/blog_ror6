class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }
  has_rich_text :content
end
