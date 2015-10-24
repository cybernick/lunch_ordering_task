require 'rails_helper'
describe CoursesController do
  shared_examples 'full access to Courses' do |course, type, course_class|
    describe "POST #create for #{type}" do
      context 'with valid attributes' do
        it "saves the new #{type} in the database" do
          expect{
            post :create, course: attributes_for(course), type: type
          }.to change(course_class, :count).by(1)
        end

        it 'redirects to items#show' do
          post :create,
               course: attributes_for(course), type: type
          expect(response).to redirect_to items_show_path
        end
      end

      context 'with invalid attributes' do
        it 'dont saves the new course in the database' do
          create(course)
          expect{
            post :create, course: attributes_for(course, name: nil), type: type
          }.to change(course_class, :count).by(0)
        end
      end
    end
  end

  describe 'admin access to courses' do
    before :each do
      @user = create(:admin)
      @menu = create(:menu)
      sign_in @user
    end

    it_behaves_like 'full access to Courses' ,  :first_course ,'FirstCourse' , FirstCourse
    it_behaves_like 'full access to Courses' ,  :second_course ,'SecondCourse' , SecondCourse
    it_behaves_like 'full access to Courses' ,  :drink ,'Drink' , Drink
  end

  describe 'user access to courses' do
    describe 'GET #show' do
      it 'response to root_url' do
        user = create(:user)
        user = create(:user)
        sign_in user
        post :create, course: attributes_for(:course)
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'guest access to courses' do
    describe 'GET #show' do
      it 'response to new_user_session_path' do
        post :create, course: attributes_for(:course)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end