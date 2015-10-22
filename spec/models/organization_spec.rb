require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token)}
  before :each do
    @organization = create(:organization)
  end
  describe '#generate_authentication_token!' do
    it 'generates a unique token' do
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      @organization.generate_authentication_token!
      expect(@organization.auth_token).to eql "auniquetoken123"
    end

    it 'generates another token when one already has been taken' do
      existing_org = FactoryGirl.create(:organization, auth_token: "auniquetoken123")
      @organization.generate_authentication_token!
      expect(@organization.auth_token).not_to eql existing_org.auth_token
    end
  end
end
