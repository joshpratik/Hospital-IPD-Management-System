FactoryBot.define do
  factory :address do
    trait :valid do
      locality { Faker::Address.street_address }
      city { Faker::Address.city }
      state { Faker::Address.state }
      pin { Faker::Number.number(digits: 6) }
      association :user_detail
    end
  end
end

