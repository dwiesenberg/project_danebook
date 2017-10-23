require 'rails_helper'

feature "Commenting", :type => :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
  	sign_in_user(user)
  	visit user_posts_path(post.author)
  end

  scenario "on a post" do
  	fill_in "comment-on-post#{post.id}", with: "The greatest comment in history - God"
  	expect{ click_button "submit-comment-post#{post.id}" }.to change(post.comments, :count).by(1)
  end

end
