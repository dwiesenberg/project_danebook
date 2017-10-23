require 'rails_helper'
require 'pry'

feature "Post actions", :type => :feature do
  let(:user){create(:user)}

  before do
  	sign_in_user(user)

    visit user_posts_path(user)

    fill_in 'post_body', with: "All hail the supreme divine emperor, Peter, god of all worlds!"

    click_button 'Post'

    @post = Post.last
  end

  scenario 'post on own timeline' do
    expect(page).to have_content "All hail the supreme divine emperor, Peter, god of all worlds!"
  end

  scenario 'delete own post' do
  	# delete the post using the find and click

  	# expect that post to not exist
  	expect{ click_link "delete-post-#{@post.id}" }.to change(Post, :count).by(-1)
  end

  context 'liking a post' do
  	scenario 'likable is spelled correctly' do
  		expect(Like.first).not_to respond_to(:likeable)
  	end

  	scenario "like a post" do
  		expect{ click_link "like-post-#{@post.id}" }.to change(Like, :count).by(1)
  		expect{ click_link "like-post-#{@post.id}" }.to change(@post.likes, :count).by(1)
  	end
  end

end
