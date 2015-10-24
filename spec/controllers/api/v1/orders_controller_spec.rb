require 'rails_helper'
describe Api::V1::OrdersController do
  describe 'GET #index' do
    before(:each) do
      @organization = create(:organization)
      api_authorization_header @organization.auth_token
      @user = create(:user, organization: @organization)
      @first_course = create(:first_course)
      @second_course = create(:second_course)
      @drink = create(:drink)
      create(:order, user: @user, first_course: @first_course, second_course: @second_course,
      drink: @drink)
      get :index, format: :json
    end

    it 'returns 1 records from the database' do
      orders_response = json_response[:orders]
      expect(orders_response.length).to eq(1)
    end
    it 'returns the objects into each product' do
      orders_response = json_response[:orders]
      orders_response.each do |order_response|
        expect(order_response[:user][:name]).to  eql @user.name
        expect(order_response[:first_course][:name]).to  eql @first_course.name
        expect(order_response[:second_course][:name]).to eql @second_course.name
        expect(order_response[:drink][:name]).to eql @drink.name
      end
    end

    it { expect(response).to have_http_status(200) }
  end
  describe 'GET #index for bad organization' do
    before(:each) do
      @organization = create(:organization)
      @bad_organization = create(:organization)
      api_authorization_header @bad_organization.auth_token
      @user = create(:user, organization: @organization)
      @first_course = create(:first_course)
      @second_course = create(:second_course)
      @drink = create(:drink)
      create(:order, user: @user, first_course: @first_course, second_course: @second_course,
             drink: @drink)
      get :index, format: :json
    end

    it 'returns 0 records from the database' do
      orders_response = json_response[:orders]
      expect(orders_response.length).to eq(0)
    end

    it { expect(response).to have_http_status(200) }
  end
end