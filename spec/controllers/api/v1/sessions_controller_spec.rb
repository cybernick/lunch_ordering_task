require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'POST #create' do

    before(:each) do
      @organization = create(:organization)
    end

    context 'when the credentials are correct' do

      before(:each) do
        credentials = { email: @organization.email, password: 'password' }
        post :create, { session: credentials }
      end

      it 'returns the user record corresponding to the given credentials' do
        @organization.reload
        expect(json_response[:organization][:auth_token]).to eql @organization.auth_token
      end

      it { should respond_with 200 }
    end

    context 'when the credentials are incorrect' do

      before(:each) do
        credentials = { email: @organization.email, password: 'invalidpassword' }
        post :create, { session: credentials }
      end

      it 'returns a json with an error' do
        expect(json_response[:errors]).to eql 'Invalid email or password'
      end

      it { should respond_with 422 }
    end
  end
  describe 'DELETE #destroy' do

    before(:each) do
      @organization = create(:organization)
      sign_in @organization
      delete :destroy, id: @organization.auth_token
    end

    it { should respond_with 204 }

  end
end
