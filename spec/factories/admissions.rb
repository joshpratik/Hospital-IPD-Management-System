FactoryBot.define do
  factory :admission do
    admission_date { Faker::Date.in_date_period }
    discharge_date { Faker::Date.in_date_period }
    dignostic { Faker::Quote.famous_last_words }
    admission_status { ['admitted', 'discharged'].sample }
    association :patient
    association :staff
    association :room
  end
end
