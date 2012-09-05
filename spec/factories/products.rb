# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product ##{n}" }
    description "Some really descriptive description"
    sequence(:image_url) { |n| "product_#{n}_image.jpg" }
    price "9.99"
  end
end
