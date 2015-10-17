require 'rails_helper'
describe OrdersController do
  shared_examples 'full access to Order' do
    describe 'GET #show' do
      before :each do
        @menu = create(:menu)
      end
      it 'assigns the requested orders to Order.current(Time.zone.today)' do
        2.times{create(:order)}
        get :show, id: @menu
        expect(assigns(:orders)).to eq Order.current(Time.zone.today)
      end

      it 'redirects to menus#show' do
        post :show, id: @menu
        expect(response).to render_template :show
      end
    end
  end
  shared_examples 'private acces to Order' do
    describe 'POST #create' do
      before :each do
        @menu = create(:menu)
      end
      context 'with valid attributes' do
        it 'assigns the requested order to @order' do
          order = create(:order,user: @user)
          post :create, order: attributes_for(:order)
          expect(assigns(:order)).to eq order
        end

        it 'redirects to menus#show' do
          post :create, order: attributes_for(:order)
          expect(response).to redirect_to menu_path(@menu)
        end
      end
    end
  end
  describe 'admin access to menus' do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like 'full access to Order'
    it_behaves_like 'private acces to Order'
  end
  describe 'user access to menus' do
    before :each do
      @user = create(:user)
      @user = create(:user)
      sign_in @user
    end
    it_behaves_like 'private acces to Order'
  end
  describe 'guest access to menus' do
    describe 'GET #show' do
      it 'redirect_to new_user_session_path ' do
        @menu = create(:menu)
        get :show, id: @menu
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'POST #create' do
      before :each do
        @menu = create(:menu)
      end
      it 'redirect_to new_user_session_path' do
        order = create(:order,user: @user)
        post :create, order: attributes_for(:order)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end