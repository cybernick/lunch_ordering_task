
require 'rails_helper'

describe Drink do
  it { should respond_to(:orders) }
  it { should respond_to(:menus) }
  it "is valid with a name and a price" do
    expect(build(:drink)).to be_valid
  end
  it "is invalid without a name " do
    drink = build(:drink, name: nil)
    drink.valid?
    expect(drink.errors[:name]).to include("can't be blank")
  end
  it "is invalid without a price " do
    drink = build(:drink, price: nil)
    drink.valid?
    expect(drink.errors[:price]).to include("can't be blank")
  end
end