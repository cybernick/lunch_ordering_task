class Menu < ActiveRecord::Base
  has_and_belongs_to_many :first_courses
  has_and_belongs_to_many :second_courses
  has_and_belongs_to_many :drinks
end
