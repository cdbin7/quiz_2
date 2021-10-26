FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) {|n| "example-#{n}@gmail.com"}
    password{"123"}
  end
end
