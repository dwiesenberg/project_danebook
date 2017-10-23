class Like < ActiveRecord::Base

	belongs_to :likable, polymorphic: true
	belongs_to :user

	validates :user, :likable_type, presence: true
	validates :likable_type, inclusion:  ['Photo', 'Comment', 'Post']

end