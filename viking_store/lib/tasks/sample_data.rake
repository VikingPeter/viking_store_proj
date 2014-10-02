module Faker
  class MakeDate < Base
    class << self
      def months_ago(months=1)
        #return a random day in the past 7 days
        today = ::Date.today
        today = today.downto(today - (30*months)).to_a
        today.shuffle[0]
      end
    end
  end
end


namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_address
    make_payment
    make_product
    make_category
    make_cart
    make_order

  end
end

def make_users #make 330 users total
  10.times do |n| #10 users from 6 months ago
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone = Faker::Number.number(10)
    create = Faker::MakeDate.months_ago(6)
    User.create!(first_name: first_name, last_name: last_name, 
    email: email, phone: phone, created_at: create)
  end

  20.times do |n| #20 users from 5 months ago
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone = Faker::Number.number(10)
    create = Faker::MakeDate.months_ago(5)
    User.create!(first_name: first_name, last_name: last_name, 
    email: email, phone: phone, created_at: create)
  end

  40.times do |n| #40 users from 4 months ago
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone = Faker::Number.number(10)
    create = Faker::MakeDate.months_ago(4)
    User.create!(first_name: first_name, last_name: last_name, 
    email: email, phone: phone, created_at: create)
  end

  60.times do |n| #60 users from 3 months ago
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone = Faker::Number.number(10)
    create = Faker::MakeDate.months_ago(3)
    User.create!(first_name: first_name, last_name: last_name, 
    email: email, phone: phone, created_at: create)
  end

  80.times do |n| #80 users from 2 months ago
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone = Faker::Number.number(10)
    create = Faker::MakeDate.months_ago(2)
    User.create!(first_name: first_name, last_name: last_name, 
    email: email, phone: phone, created_at: create)
  end

  120.times do |n| #120 users from 1 months ago
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone = Faker::Number.number(10)
    create = Faker::MakeDate.months_ago(1)
    User.create!(first_name: first_name, last_name: last_name, 
    email: email, phone: phone, created_at: create)
  end

end

def make_address
  users = []
  (1..330).each {|i| users << i}

 (1..330).each do |n| #everyone gets a first address
  street = Faker::Address.street_address
  city = Faker::Address.city
  state = Faker::Address.state_abbr
  zip = Faker::Address.zip
  Address.create(user_id: n, street1: street,
    city1: city, state1: state, zip1: zip,
    default_address1: true)
 end

 (1..200).each do |n| #200  people get a second address
    street = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip = Faker::Address.zip
    Address.update(n, street2: street,
      city2: city, state2: state, zip2: zip,
      default_address2: false)
 end

  (1..100).each do |n| #100  people get a third address
    street = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip = Faker::Address.zip
    Address.update(n, street3: street,
      city3: city, state3: state, zip3: zip,
      default_address3: false)
 end

  (1..50).each do |n| #50  people get a fourth address
    street = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip = Faker::Address.zip
    Address.update(n, street4: street,
      city4: city, state4: state, zip4: zip,
      default_address4: false)
 end

  (1..20).each do |n| #20  people get a fifth address
    street = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip = Faker::Address.zip
    Address.update(n, street5: street,
      city5: city, state5: state, zip5: zip,
      default_address5: false)
 end
end

def make_payment
  months, years = [],[]
  (1..12).each {|i| months << i}
  (2014..2020).each {|i| years << i}
  (1..330).each do |n|
      cc = Faker::Number.number(16)
      exp_month = months.sample
      exp_year = years.sample
      ccv = rand(999)
      Payment.create!(user_id: n, cc_number: cc, exp_month: exp_month,
        exp_year: exp_year, ccv: ccv)
  end
end

def make_product
  30.times do |n| #create 30 products
    title = Faker::Commerce.product_name
    description = Faker::Hacker.say_something_smart
    price = Faker::Commerce.price
    sku = Faker::Lorem.characters(6)
    Product.create!(title: title, description: description,
      price: price, sku: sku)
  end
end

def make_category
  products = []
  (1..30).each {|i| products << i } #30 products
  6.times do |n| #6 categories
    name = Faker::Lorem.words(2)[0]
    description = Faker::Hacker.say_something_smart
    Category.create!(product_id: products.sample, name: name, 
      description: description)
  end
end

def make_cart
  (1..150).each do |n| #150 active carts
    products = []
    (1..30).each {|i| products << i } #30 products
    quantity = []
    (1..10).each {|i| quantity << i} #up to 10 units
    Cart.create!(user_id: n, product_id: products.sample,
      product_quantity: quantity.sample)
  end
end

def make_order
  (1..100).each do |n| #100 historical orders
    Order.create!(cart_id: n)
  end

end
