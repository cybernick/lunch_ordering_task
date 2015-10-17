require 'rails_helper'
describe PagesController do
  shared_examples 'full access to pages' do
    describe 'GET #today' do
      before :each do
        @admin = create(:admin)
        sign_in @admin
      end
        it 'assigns the requested @order to Order.current(Time.zone.today)' do
          order = create(:order,user: @admin)
          get :today
          expect(assigns(:orders)).to eq Order.current(Time.zone.today)
        end
        it 'assigns the requested total_cost to Order.total_cost' do
          order = create(:order,user: @admin)
          get :today
          expect(assigns(:total_cost)).to eq Order.total_cost
        end
    end
    describe 'GET #order' do
      before :each do
        @admin = create(:admin)
        sign_in @admin
      end
      it 'assigns the requested @menus to Menu.all' do
        menu = create(:menu)
        get :order
        expect(assigns(:menus)).to eq Menu.all
      end
    end
  end
  shared_examples 'private access to pages' do
    describe 'GET #menu' do
      before :each do
        @admin = create(:admin)
        sign_in @admin
      end
        it 'assigns the requested @menus to Menu.all' do
          menu = create(:menu)
          get :menu
          expect(assigns(:menus)).to eq Menu.all
        end
    end
  end
  shared_examples 'public pages' do
    describe 'GET #home' do
      it 'response to home page' do
        get :home
        expect(response).to render_template :home
      end
    end
    describe 'GET #help' do
      it 'response to help page' do
        get :help
        expect(response).to render_template :help
      end
    end
    describe 'GET #contact' do
      it 'response to contact page' do
        get :contact
        expect(response).to render_template :contact
      end
    end
    describe 'GET #about' do
      it 'response to about page' do
        get :about
        expect(response).to render_template :about
      end
    end
  end
  describe 'admin access to pages' do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like 'full access to pages'
    it_behaves_like 'private access to pages'
    it_behaves_like 'public pages'
  end
  describe 'user access to menus' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'private access to pages'
    it_behaves_like 'public pages'

    describe 'GET #order' do
      it 'response to new_user_session_path' do
        @menu = create(:menu)
        get :order
        expect(response).to redirect_to root_url
      end
    end

    describe 'GET #today' do
      it 'response to new_user_session_path' do
        get :today
        expect(response).to redirect_to root_url
      end
    end
  end
  describe 'guest access to menus' do
    it_behaves_like 'public pages'
    describe 'GET #menu' do
      it 'response to new_user_session_path' do
        get :menu
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #order' do
      it 'response to new_user_session_path' do
        get :order
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #order' do
      it 'response to new_user_session_path' do
        get :today
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end