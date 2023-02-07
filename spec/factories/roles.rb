FactoryBot.define do
  factory :role do
    name { ['admin', 'staff', 'patient'].sample }
  end
end
