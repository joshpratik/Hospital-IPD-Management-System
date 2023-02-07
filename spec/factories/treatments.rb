FactoryBot.define do
  factory :treatment do
    quantity { Faker::Number.between(from: 1, to: 1000) }
    association :admission
    association :medicine
  end
end
