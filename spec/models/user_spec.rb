
require 'rails_helper'

describe User do
  it { should respond_to(:orders) }
  it { should belong_to :organization }
  it 'is a admin as first registered user' do
    create(:user)
    expect(User.first.admin?).to be_truthy
  end
  it "isn't a admin as second registered user" do
    2.times{ create(:user) }
    expect(User.second.admin?).not_to be_truthy
  end
end