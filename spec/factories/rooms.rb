FactoryBot.define do
  factory :room do
    room_type { ['general', 'private', 'emergency'].sample }
    description { Faker::Restaurant.description }
    charges { Faker::Number.between(from: 100.0, to: 10000.0) }
    capacity { Faker::Number.between(from: 1, to: 100) }
  end
end
