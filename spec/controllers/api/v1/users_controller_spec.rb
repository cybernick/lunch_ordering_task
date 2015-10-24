require 'rails_helper'
describe Api::V1::UsersController do
  describe 'GET #show' do
    before(:each) do
      @organization = create(:organization)
      api_authorization_header @organization.auth_token
      @user = create(:user, organization: @organization)
      get :show, id: @user.id, format: :json
    end

    it 'returns the information about a reporter on a hash' do
      user_response = json_response[:user]
      expect(user_response[:name]).to eql @user.name
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #index' do
    before(:each) do
      @organization = create(:organization)
      api_authorization_header @organization.auth_token
      4.times { create(:user, organization: @organization) }
      get :index, format: :json
    end

    it 'returns 4 records from the database' do
      users_response = json_response[:users]
      expect(users_response.length).to eq(4)
    end

    it { expect(response).to have_http_status(200) }
  end
end