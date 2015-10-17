require 'rails_helper'

feature 'User behavior' do
  shared_examples 'user and admin access to profile' do
    scenario 'view and edit profile' do
      visit root_path
      click_link 'Profile'
      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
      click_link 'Change your profile'
      fill_in 'Name' , with: 'NewName'
      fill_in 'Email', with: 'NewEmail@mail.com'
      fill_in 'Password' , with: 'newpassword'
      fill_in 'Password confirmation' , with: 'newpassword'
      fill_in 'Current password', with: 'password'
      click_button 'Update'
      expect(current_path).to eq user_path(@user)
      expect(page).to have_content 'NewName'
      expect(page).to have_content 'newemail@mail.com'
    end
  end

  describe 'user access to profile' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'user and admin access to profile'
    scenario 'not able to see another profile' do
      @another_user = create(:user)
      visit user_path(@another_user)
      expect(current_path).to eq root_path
    end
    scenario 'not able to see all users' do
      visit users_path
      expect(current_path).to eq root_path
    end
  end
  describe 'admin access to users and profiles' do
    before :each do
      @user = create(:user)
      @first_user = create(:user)
      sign_in @user
    end
    it_behaves_like 'user and admin access to profile'
    scenario 'view all users' do
      click_link 'Users'
      expect(page).to have_content @first_user.name
      expect(page).to have_content @first_user.email
    end
  end
  describe 'guest access to profile' do
    scenario 'not able to see another profile' do
      @another_user = create(:user)
      visit user_path(@another_user)
      expect(current_path).to eq new_user_session_path
    end
    scenario 'not able to see all users' do
      visit users_path
      expect(current_path).to eq new_user_session_path
    end
  end
end