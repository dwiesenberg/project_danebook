require 'rails_helper'
require 'pry'

RSpec.describe Post, :type => :model do
	let(:post){build(:post)}

  describe "associations" do
  	#  belongs_to :author
  	it { is_expected.to respond_to(:author) }

  	#  has_many :likes, as: :likeable, dependent: :destroy
  	it { is_expected.to respond_to(:likes) }

  	#  has_many :comments, as: :commentable, dependent: :destroy
  	it { is_expected.to respond_to(:comments) }

  end

  describe "creating a post" do
	  #  validates :author_id, :body, presence: true
  	it "should validate the presence of author_id" do
  		# expect(post.author_id).to_be a_integers
  		expect(post).to validate_presence_of :author_id
  	end

  	it "should validate the presence of author" do
  		post.author_id = 999999
  		expect{ post.save! }.to raise_error
  	end

  	it "should not allow a blank post" do
	  	expect(post).to validate_presence_of :body
	  end

  end

end
