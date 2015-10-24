
require 'rails_helper'

describe Course do
  before :each do
    create(:course)
  end
  let(:invalid_course) { build(:course, name: nil, price: nil)}
  subject(:course) { Course.first }

  it { should respond_to(:orders) }
  it { should respond_to(:menus) }

  it 'is valid with a name and a price' do
    expect(course).to be_valid
  end

  it 'is invalid without a name' do
    invalid_course.valid?
    expect(invalid_course.errors[:name]).to include('can\'t be blank')
  end

  it 'is invalid without a price' do
    invalid_course.valid?
    expect(invalid_course.errors[:price]).to include('can\'t be blank')
  end

  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end