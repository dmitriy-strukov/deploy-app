require 'factory_girl'

FactoryGirl.define do
  factory :article do
    title { Faker::Name.title[0, 30] }
    description { Faker::Lorem.characters(100) }
  end
end
