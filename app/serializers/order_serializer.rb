class OrderSerializer < ActiveModel::Serializer
  attributes :id, :day
  has_one :user
  has_one :first_course
  has_one :second_course
  has_one :drink
end
