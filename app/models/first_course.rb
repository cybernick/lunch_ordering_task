class FirstCourse < ActiveRecord::Base
  validates :name, :price , presence: true
  has_and_belongs_to_many :menus
  has_many :orders
  def name_with_price
    "#{name}, #{price} usd"
  end
end
