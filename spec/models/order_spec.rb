
require 'rails_helper'

describe Order do
  let(:user) { create(:user) }
  let(:first_course) { create(:first_course) }
  let(:second_course) { create(:second_course) }
  let(:drink) { create(:drink) }

  it 'belongs to a use' do
    order = build(:order, user: user)
    expect(order.user).to be user
  end

  it 'belongs to a first_course' do
    order = build(:order, first_course: first_course)
    expect(order.first_course).to be first_course
  end

  it 'belongs to a second_course' do
    order = build(:order, second_course: second_course)
    expect(order.second_course).to be second_course
  end

  it 'belongs to a drink' do
    order = build(:order, drink: drink)
    expect(order.drink).to be drink
  end

  it 'deny to user has more than one order per day' do
    create(:order,user: user)
    expect {create(:order,user: user)}.to  raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Day has already been taken')
  end

  it 'today total_cost should be correct' do
    2.times {create(:order)}
    expect(Order.total_cost).to eql 3000.0
  end

end