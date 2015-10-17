require 'rails_helper'
describe ItemsController do
  shared_examples 'full access to Items' do
    describe 'GET #show' do
      it 'assigns the requested first_courses,second_first_courses to match_array([first_course,second_first_course])' do
        first_course = create(:first_course)
        second_first_course = create(:first_course)
        @menu = create(:menu, first_courses: [first_course,second_first_course])
        get :show
        expect(assigns(:first_courses)).to match_array([first_course,second_first_course])
      end
      it 'redirects to items#show' do
        get :show
        expect(response).to render_template :show
      end
    end
  end
  describe 'user access to menus' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    describe 'GET #show' do
      it 'response to root_url' do
        get :show
        expect(response).to redirect_to root_path
      end
    end
  end
  describe 'admin access to menus' do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like 'full access to Items'
  end

  describe 'guest access to menus' do
    describe 'GET #show' do
      it 'response to new_user_session_path' do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end