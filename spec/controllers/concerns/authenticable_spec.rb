require 'rails_helper'

class Authentication
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe '#current_organization' do
    before do
      @organization = create(:organization)
      request.headers['Authorization'] = @organization.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end
    it 'returns the user from the authorization header' do
      expect(authentication.current_organization.auth_token).to eql @organization.auth_token
    end
  end
  describe '#authenticate_with_token' do
    before do
      @organization = create(:organization)
      #authentication.stub(:current_organization).and_return(nil)
      #response.stub(:response_code).and_return(401)
      #response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      #authentication.stub(:response).and_return(response)
    end

    it 'render a json error message' do
      expect(json_response[:errors]).to eql 'Not authenticated'
    end

    it { expect(response.status).to eq 401 }
  end
end