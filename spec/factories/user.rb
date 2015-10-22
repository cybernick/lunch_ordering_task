require 'faker'

FactoryGirl.define do
  factory :user do
    association :organization
    sequence(:name) {|n| "user-#{n}"}
    sequence(:email) {|n| "user-#{n}@lunch.org"}
    password 'password'
    password_confirmation { password }

    factory :admin do
      admin true
    end
  end
end