require 'rails_helper'

feature 'Admin behavior' do
  shared_examples 'admin access to today order' do
    before :each do
      @first_course = create(:first_course)
      @second_course = create(:second_course)
      @drink = create(:drink)
      @user = create(:user)
      @order = create(:order,user: @user, first_course:@first_course, second_course: @second_course, drink: @drink)
      @menu = create(:menu, first_courses:[@first_course], second_courses: [@second_course], drinks: [@drink])
    end
    scenario 'view today order' do
      click_link 'Today'
      expect(current_path).to eq pages_today_path
      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
      expect(page).to have_content @first_course.name
      expect(page).to have_content @first_course.price
      expect(page).to have_content @second_course.name
      expect(page).to have_content @second_course.price
      expect(page).to have_content @drink.name
      expect(page).to have_content @drink.price
      expect(page).to have_content Order.total_cost
    end
  end
  describe 'user access to today orders' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    scenario 'should not visit today order page' do
      visit pages_today_path
      expect(current_path).to eq root_path
    end
  end
  describe 'admin access to today order' do
    before :each do
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'admin access to today order'
  end
  describe 'guest access to today order' do
    scenario 'should not visit Today order path' do
      visit pages_today_path
      expect(current_path).to eq new_user_session_path
    end
  end
end