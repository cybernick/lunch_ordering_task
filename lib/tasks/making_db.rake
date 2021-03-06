namespace :db do
  desc 'Fill database with data'
  task populate: :environment do
    make_users
    make_menu
    make_first_course
    make_second_course
    make_drink_course
    make_orders
  end
end
def make_orders
  User.all.each do |user|
    Order.create(day: Time.zone.today,user:user,first_course:FirstCourse.first,second_course:
    SecondCourse.second,drink: Drink.second)
  end
end
def make_users
  username = "user-#{1}"
  email = "user-#{1}@lunch.org"
  org_email = "org-#{1}@lunch.org"
  password  = "password"

  @organization = Organization.create(name: 'Organization',email: org_email,password: password,
      password_confirmation: password)
  User.create(name: username,email:    email,
               password: password,
               password_confirmation: password, admin: true, organization_id: @organization.id)
  9.times do |n|
    username = "user-#{n+2}"
    email = "user-#{n+2}@lunch.org"
    password  = "password"
    User.create(name: username,email:    email,
                 password: password,
                 password_confirmation: password, admin: false, organization_id: @organization.id)
  end
end

def make_menu
  10.times do |n|
    Menu.create(day: Time.zone.today - n.day)
  end
end


def make_first_course
  10.times do |n|
    name = "borsch-#{n}"
    10.times do |m|
      @menu = Menu.find_by_id(m+1)
      @menu.first_courses.create(name: name,price: 500);
    end
  end
end

def make_second_course
  10.times do |n|
    name = "kotleta-#{n}"
    10.times do |m|
      @menu = Menu.find_by_id(m+1)
      @menu.second_courses.create(name: name,price: 500);
    end
  end
end

def make_drink_course
  10.times do |n|
    name = "voda-#{n}"
    10.times do |m|
      @menu = Menu.find_by_id(m+1)
      @menu.drinks.create(name: name,price: 500);
    end
  end
end