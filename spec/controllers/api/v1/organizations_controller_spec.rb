require 'rails_helper'

describe Api::V1::OrganizationsController do
  describe 'GET #show' do
    before(:each) do
      @organization = create(:organization)
      api_authorization_header @organization.auth_token
      get :show, id: @organization.id, format: :json
    end

    subject(:organization_response) { json_response[:organization] }

    it 'has the users ids as an embeded object' do
      expect(organization_response[:user_ids]).to eql []
    end

    it 'returns the information about a reporter on a hash' do
      expect(organization_response[:email]).to eql @organization.email
    end
    it 'returns the information about a reporter on a hash' do
      expect(organization_response[:name]).to eql @organization.name
    end

    it { expect(response).to have_http_status(200) }
  end
end