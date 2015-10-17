require 'rails_helper'
describe FirstCoursesController do
  shared_examples "full access to FirstCourse" do
    describe "POST #create" do
      before :each do
        @menu = create(:menu)
      end
      context "with valid attributes" do
        it "saves the new first_course in the database" do
          create(:first_course)
          expect{
            post :create, first_course: attributes_for(:first_course)
          }.to change(FirstCourse, :count).by(1)
        end

        it "redirects to items#show" do
          post :create,
               first_course: attributes_for(:first_course)
          expect(response).to redirect_to items_show_path
        end
      end
      context "with invalid attributes" do
        it "don't saves the new first_course in the database" do
          create(:first_course)
          expect{
            post :create, first_course: attributes_for(:first_course, name: nil)
          }.to change(FirstCourse, :count).by(0)
        end

        it "redirects to items#show" do
          post :create,
               first_course: attributes_for(:first_course, name: nil)
          expect(response).to redirect_to items_show_path
        end
      end
    end
  end
  describe "admin access to drinks" do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like "full access to FirstCourse"
  end
  describe "guest access to first_course" do
    describe "GET #show" do
      it "response to new_user_session_path" do
        post :create, first_course: attributes_for(:first_course)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end