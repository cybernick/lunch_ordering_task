class Order < ActiveRecord::Base
  validates_uniqueness_of :day, scope: :user_id
  belongs_to :user
  belongs_to :first_course
  belongs_to :second_course
  belongs_to :drink

  def total
    first_course.price.to_f + second_course.price.to_f + drink.price.to_f
  end
  def self.current(day)
    where(day:  day)
  end
  def self.total_cost
    @day = Time.zone.today
    @orders = Order.current(@day)
    @total_cost = 0
    @orders.each do |order|
      @total_cost = @total_cost + order.total
    end
    return @total_cost
  end
end
