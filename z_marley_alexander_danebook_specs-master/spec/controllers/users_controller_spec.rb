require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

    # THIS GOES ELSEWHERE
    # before :each do
    #   request.cookies["auth_token"] = user.auth_token
    # end

    # context 'when not logged in' do
    #   it 'should redirect to root if visiting a protected page' do
    #     get :show, :id => user.id
    #     expect(response).to redirect_to login_url
    #   end
    # end


  describe 'POST #create' do

    context 'with valid input' do

      it 'should save the user' do
        expect{post :create, user: attributes_for(:user)}.
                             to change(User, :count).by(1)
      end

      it 'should build a profile for the user' do
        expect{post :create, user: attributes_for(:user)}.
                             to change(Profile, :count).by(1)
      end

      it 'should associate the profile with the user' do
        post :create, user: attributes_for(:user)
        user = assigns(:user)
        expect(assigns(:profile)).to equal(user.profile)
      end

      it 'should redirect to the profile' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_profile_path(assigns(:user))
      end

    end

    context 'with invalid input' do

      it 'should not save the user' do
        expect{post :create, user: attributes_for(:user, password: "nope")}.
                                                  not_to change(User, :count)
      end

      it 'should re-render the new user path' do
        post :create, user: attributes_for(:user, password: "nope")
        expect(response).to render_template :new
      end

      it 'should not create a profile' do
        expect{post :create, user: attributes_for(:user, password: "nope")}.
                                                not_to change(Profile, :count)
      end

      it 'should return the user object with errors on it' do
        post :create, user: attributes_for(:user, password: "nope")
        expect(assigns(:user).errors.count).to be > 0
      end
    end

  end


end
