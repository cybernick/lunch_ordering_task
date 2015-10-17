require 'rails_helper'

feature 'User behavior' do
  shared_examples 'user and admin access to menu' do
    before :each do
      @first_course = create(:first_course)
      @second_course = create(:second_course)
      @drink = create(:drink)
      @today_menu = create(:menu, first_courses:[@first_course], second_courses: [@second_course], drinks: [@drink])
      @past_day_menu = create(:menu, day: Time.zone.today - 1.day, first_courses:[@first_course], second_courses: [@second_course], drinks: [@drink])
    end
    scenario 'view today_menu and make order' do
      click_link 'Menus'
      expect(current_path).to eq pages_menu_path
      expect(page).to have_link @today_menu.day
      expect(page).to have_link @past_day_menu.day
      click_link @today_menu.day
      expect(current_path).to eq menu_path(@today_menu)
      expect(page).to have_content @first_course.name
      expect(page).to have_content @first_course.price
      expect(page).to have_content @second_course.name
      expect(page).to have_content @second_course.price
      expect(page).to have_content @drink.name
      expect(page).to have_content @drink.price
      find('#first_course_id').find(:xpath, 'option[1]').select_option
      find('#second_course_id').find(:xpath, 'option[1]').select_option
      find('#drink_id').find(:xpath, 'option[1]').select_option
      click_button 'Create Order'
      within(:css, 'li#first'){
        expect(page).to have_content @first_course.name
        expect(page).to have_content @first_course.price
      }
      within(:css, 'li#second'){
        expect(page).to have_content @second_course.name
        expect(page).to have_content @second_course.price
      }
      within(:css, 'li#drink'){
        expect(page).to have_content @drink.name
        expect(page).to have_content @drink.price
      }
    end
    scenario 'view past_day_menu and not make order' do
      click_link 'Menus'
      expect(current_path).to eq pages_menu_path
      expect(page).to have_link @today_menu.day
      expect(page).to have_link @past_day_menu.day
      click_link @past_day_menu.day
      expect(current_path).to eq menu_path(@past_day_menu)
      expect(page).to have_content @first_course.name
      expect(page).to have_content @first_course.price
      expect(page).to have_content @second_course.name
      expect(page).to have_content @second_course.price
      expect(page).to have_content @drink.name
      expect(page).to have_content @drink.price
      expect(page).not_to have_css('#first_course_id')
      expect(page).not_to have_css('#second_course_id')
      expect(page).not_to have_css('#drink_id')
      expect(page).not_to have_button 'Create Order'
    end
  end
  describe 'user access to menus' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'user and admin access to menu'
    scenario 'should not visit Add Meals to Menu' do
      visit items_show_path
      expect(current_path).to eq root_path
    end
  end
  describe 'admin access to menus' do
    before :each do
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'user and admin access to menu'
    scenario 'add courses for today menu' do
      click_link 'Add meals to Menu'
      expect(current_path).to eq items_show_path
      find('#new_first_course' ).fill_in 'Name', with: 'Borsch'
      find('#new_first_course' ).fill_in 'Price', with: '123.0'

      first(:button, 'Submit').click
      expect(page).to have_content 'Borsch'
      expect(page).to have_content '123.0'
    end
  end
  describe 'guest access to menu' do
    scenario 'should not visit Menu path' do
      visit pages_menu_path
      expect(current_path).to eq new_user_session_path
    end
    scenario 'should not visit Add Meals to Menu' do
      visit items_show_path
      expect(current_path).to eq new_user_session_path
    end
  end
end