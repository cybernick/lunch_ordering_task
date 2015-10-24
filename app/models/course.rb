class Course < ActiveRecord::Base
  validates :name, :price , presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :first_courses, -> { where(type:  'FirstCourse') }
  scope :second_courses, -> { where(type: 'SecondCourse') }
  scope :drinks, -> { where(type: 'Drink') }

  has_and_belongs_to_many :menus
  has_many :orders

  def self.type
    %w(FirstCourse SecondCourse Drink)
  end

  def name_with_price
    "#{name}, #{price} usd"
  end
end
