FactoryBot.define do
  factory :card do
    association :user
    association :shop

    bonuses { 500 }
  end
end
