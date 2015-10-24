class Menu < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :first_courses, association_foreign_key: 'course_id', join_table: 'courses_menus'
  has_and_belongs_to_many :second_courses, association_foreign_key: 'course_id', join_table: 'courses_menus'
  has_and_belongs_to_many :drinks, association_foreign_key: 'course_id', join_table: 'courses_menus'
end
