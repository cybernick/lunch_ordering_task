require 'rails_helper'

class Authentication < ActionController::Base
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe '#current_organization' do
    before do
      @organization = create(:organization)
      api_authorization_header @organization.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end
    it 'returns the user from the authorization header' do
      expect(authentication.current_organization.auth_token).to eql @organization.auth_token
    end
  end
  describe '#authenticate_with_token' do
    before do
      @organization = create(:organization)
      allow(authentication).to receive(:request).and_return(request)

    end

    it 'nil current_organization when we doesn\'t set api_authorization_header' do
      expect(authentication.current_organization).to eql nil
      expect(response).to have_http_status(200)
    end
  end
end