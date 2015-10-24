FactoryGirl.define do
  factory :organization do
    sequence(:name) {|n| "Organization-#{n}"}
    sequence(:email) {|n| "organization-#{n}@lunch.org"}
    password 'password'
    password_confirmation { password }
  end
end
