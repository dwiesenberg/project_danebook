class Post < ActiveRecord::Base

	belongs_to :author, class_name: "User"

	has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author, :author_id, :body, presence: true
end