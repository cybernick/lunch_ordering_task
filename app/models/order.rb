class Order < ActiveRecord::Base
  validates_uniqueness_of :day, scope: :user_id
  belongs_to :user
  belongs_to :first_course
  belongs_to :second_course
  belongs_to :drink

  scope :today_orders, -> { where(day: Time.zone.today) }

  class << self
    def course_price_sum(course)
      today_orders.includes(course).sum(:price)
    end

    def any_day_orders(day)
      where(day: day)
    end

    def total_cost
      course_price_sum(:first_course) + course_price_sum(:second_course) + course_price_sum(:drink)
    end
  end
end
