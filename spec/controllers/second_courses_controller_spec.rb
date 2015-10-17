require 'rails_helper'
describe SecondCoursesController do
  shared_examples 'full access to SecondCourse ' do
    describe 'POST #create' do
      before :each do
        @menu = create(:menu)
        @admin = create(:admin)
        sign_in @admin
      end
      context 'with valid attributes' do
        it 'saves the new second_course in the database' do
          create(:second_course)
          expect{
            post :create, second_course: attributes_for(:second_course)
          }.to change(SecondCourse, :count).by(1)
        end

        it 'redirects to items#show' do
          post :create,
               second_course: attributes_for(:second_course)
          expect(response).to redirect_to items_show_path
        end
      end
      context 'with invalid attributes' do
        it 'dont saves the new second_course in the database' do
          create(:second_course)
          expect{
            post :create, second_course: attributes_for(:second_course, name: nil)
          }.to change(SecondCourse, :count).by(0)
        end
      end
    end
  end
  describe 'user access to second course' do
    describe 'GET #show' do
      it 'response to root_url' do
        user = create(:user)
        user = create(:user)
        sign_in user
        post :create, second_course: attributes_for(:second_course)
        expect(response).to redirect_to root_url
      end
    end
  end
  describe 'admin access to second_course' do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like 'full access to SecondCourse '
  end
  describe 'guest access to second_course' do
    describe 'GET #show' do
      it 'response to new_user_session_path' do
        post :create, second_course: attributes_for(:second_course)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end