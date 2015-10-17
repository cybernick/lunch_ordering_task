
require 'rails_helper'

describe FirstCourse do
  it { should respond_to(:orders) }
  it { should respond_to(:menus) }
  it "is valid with a name and a price" do
    expect(build(:first_course)).to be_valid
  end
  it "is invalid without a name " do
    first_course = build(:first_course,name: nil)
    first_course.valid?
    expect(first_course.errors[:name]).to include("can't be blank")
  end
  it "is invalid without a price " do
    first_course = build(:first_course,price: nil)
    first_course.valid?
    expect(first_course.errors[:price]).to include("can't be blank")
  end
end