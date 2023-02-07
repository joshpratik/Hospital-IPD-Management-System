FactoryBot.define do
  factory :medicine do
    name { Faker::Science.element }
    price { Faker::Number.between(from: 100.0, to: 10000.0) }
  end
end
