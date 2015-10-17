require 'rails_helper'
describe MenusController do
  shared_examples 'full access to Menu' do
    describe "GET #show" do
      before :each do
        @first_course = create(:first_course)
        @second_first_course = create(:first_course)
        @menu = create(:menu, first_courses: [@first_course,@second_first_course])
        @current_order = create(:order,user: @user)
      end
      it "assigns the requested first_courses,second_first_courses to match_array([first_course,second_first_course])" do
        get :show, id: @menu
        expect(assigns(:first_courses)).to match_array([@first_course,@second_first_course])
      end
      it "assigns the requested current_order to equal @current_order" do
        get :show, id: @menu
        expect(assigns(:current_order)).to eq @current_order
      end

      it "redirects to items#show" do
        get :show, id: @menu
        expect(response).to render_template :show
      end
    end
  end
  describe "admin access to menus" do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like "full access to Menu"
  end
  describe "user access to menus" do
    before :each do
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like "full access to Menu"
  end
  describe "guest access to menus" do
    describe "GET #show" do
      context "with valid attributes" do
        it "assigns the requested first_courses,second_first_courses to match_array([first_course,second_first_course])" do
          @menu = create(:menu)
          get :show, id: @menu
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end