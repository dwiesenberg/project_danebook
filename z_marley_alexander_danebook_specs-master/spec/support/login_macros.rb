module LoginMacros

  def sign_in_user(user)
    user.profile || user.create_profile
    visit root_path

    within('#sign-in-bar') do
      fill_in 'email', with: user.email
      fill_in 'password', with: "verysecure"
    end

    click_button('Log ind')
  end

end