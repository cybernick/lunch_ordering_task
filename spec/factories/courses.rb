require 'faker'

FactoryGirl.define do
  factory :course, class:Course do
    name {Faker::Name.name}
    price 500.0
    type 'Course'

    factory :first_course, class:FirstCourse do
      type 'FirstCourse'
    end

    factory :second_course, class:SecondCourse do
      type 'SecondCourse'
    end

    factory :drink, class:Drink do
      type 'Drink'
    end
  end
end