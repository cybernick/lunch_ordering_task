require 'rails_helper'

feature 'Admin behavior' do
  shared_examples 'admin access to orders' do
    before :each do
      @first_course = create(:first_course)
      @second_course = create(:second_course)
      @drink = create(:drink)
      @user = create(:user)
      @order = create(:order,user: @user, first_course:@first_course, second_course: @second_course, drink: @drink)
      @menu = create(:menu, first_courses:[@first_course], second_courses: [@second_course], drinks: [@drink])
    end
    scenario 'view  order' do
      click_link 'Orders'
      expect(current_path).to eq pages_order_path
      expect(page).to have_link @order.day
      click_link @order.day
      expect(current_path).to eq order_path(@order)
      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
      expect(page).to have_content @first_course.name
      expect(page).to have_content @first_course.price
      expect(page).to have_content @second_course.name
      expect(page).to have_content @second_course.price
      expect(page).to have_content @drink.name
      expect(page).to have_content @drink.price
    end
  end
  describe 'user access to orders' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    scenario 'should not visit Orders page' do
      visit pages_order_path
      expect(current_path).to eq root_path
    end
  end
  describe 'admin access to order' do
    before :each do
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'admin access to orders'
  end
  describe 'guest access to order' do
    scenario 'should not visit Orders path' do
      visit pages_order_path
      expect(current_path).to eq new_user_session_path
    end
  end
end