class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  has_many :likes, as: :likable

  validates :body, length: { maximum: 10000, minimum: 3 }

  default_scope { order(created_at: :desc) }
end
