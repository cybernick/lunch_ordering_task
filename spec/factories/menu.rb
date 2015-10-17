require 'faker'

FactoryGirl.define do
  factory :menu do
    day Time.zone.today
    first_courses {[create(:first_course)]}
    second_courses {[create(:second_course)]}
    drinks {[create(:drink)]}
  end
end