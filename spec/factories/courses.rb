require 'faker'

FactoryGirl.define do
  factory :first_course do
    name {Faker::Name.name}
    price 500.0
  end
  factory :second_course do
    name {Faker::Name.name}
    price 500.0
  end
  factory :drink do
    name {Faker::Name.name}
    price 500.0
  end
end