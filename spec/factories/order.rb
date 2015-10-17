require 'faker'

FactoryGirl.define do
  factory :order do
    association :user
    association :first_course
    association :second_course
    association :drink
    day Time.zone.today
  end
end