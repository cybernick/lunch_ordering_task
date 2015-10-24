require 'rails_helper'
describe UsersController do
  shared_examples 'full access to User'do
    describe 'GET #index' do
      it 'assigns the requested users to eq User.all' do
        2.times{create(:user)}
        get :index
        expect(assigns(:user)).to eq User.all
      end
    end

    describe 'GET #show' do
      it 'assigns the requested user to eq @user' do
        @user = create(:user)
        get :show, id: @user
        expect(assigns(:user)).to eq @user
      end
    end
  end

  describe 'user access to users' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end

    describe 'GET #show' do
      it 'response to template show' do
        get :show, id: @user
        expect(response).to render_template :show
      end
    end

    describe 'GET #index' do
      it 'response to root_path' do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'admin access to user' do
    before :each do
      @user = create(:admin)
      sign_in @user
    end

    it_behaves_like 'full access to User'
  end

  describe 'guest access to user' do
    describe 'GET #show' do
      it 'response to new_user_session_path' do
        @user = create(:user)
        get :show, id: @user
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #index' do
      it 'response to root_path' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end