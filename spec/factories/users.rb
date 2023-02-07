# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :emailmissing do
      password { Faker::Internet.password }
    end
    trait :valid do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
  end
end