require 'rails_helper'
describe DrinksController do
  shared_examples 'full access to Drinks' do
    describe 'POST #create' do
      before :each do
        @menu = create(:menu)
      end
      context 'with valid attributes' do
        it 'saves the new drink in the database' do
          create(:drink)
          expect{
            post :create, drink: attributes_for(:drink)
          }.to change(Drink, :count).by(1)
        end

        it 'redirects to items#show' do
          post :create,
               drink: attributes_for(:drink)
          expect(response).to redirect_to items_show_path
        end
      end
      context 'with invalid attributes' do
        it 'dont saves the new drink in the database' do
          create(:drink)
          expect{
            post :create, drink: attributes_for(:drink, name: nil)
          }.to change(Drink, :count).by(0)
        end
      end
    end
  end

  describe 'admin access to drinks' do
    before :each do
      @user = create(:admin)
      sign_in @user
    end
    it_behaves_like 'full access to Drinks'
  end
  describe 'user access to drinks' do
    describe 'GET #show' do
      it 'response to root_url' do
        user = create(:user)
        user = create(:user)
        sign_in user
        post :create, drink: attributes_for(:drink)
        expect(response).to redirect_to root_url
      end
    end
  end
  describe 'guest access to drinks' do
    describe 'GET #show' do
      it 'response to new_user_session_path' do
        post :create, drink: attributes_for(:drink)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end