
require 'rails_helper'

describe SecondCourse do
  it { should respond_to(:orders) }
  it { should respond_to(:menus) }
  it "is valid with a name and a price" do
    expect(build(:second_course)).to be_valid
  end
  it "is invalid without a name " do
    second_course = build(:second_course, name: nil)
    second_course.valid?
    expect(second_course.errors[:name]).to include("can't be blank")
  end
  it "is invalid without a price " do
    second_course = build(:second_course, price: nil)
    second_course.valid?
    expect(second_course.errors[:price]).to include("can't be blank")
  end
end