FactoryBot.define do
  factory :user_detail do
    trait :valid do
      first_name { Faker::Name.name }
      last_name { Faker::Name.name }
      gender { Faker::Gender.binary_type }
      date_of_birth { Faker::Date.in_date_period }
      phone_no { Faker::Number.number(digits: 10) }
      association :role
      association :user
    end
  end
end
