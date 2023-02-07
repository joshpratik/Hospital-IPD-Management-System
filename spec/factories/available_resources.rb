FactoryBot.define do
  factory :available_resource do
    available_capacity { Faker::Number.between(from: 0, to: 100) }
    association :room
  end
end
