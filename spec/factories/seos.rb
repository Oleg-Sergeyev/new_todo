FactoryBot.define do
  factory :seos do
    title { FFaker::Lorem.sentence(1) }
    description { FFaker::Lorem.sentence(10) }
    keywords { FFaker::Lorem.sentence(12) }
    promoted
  end
end
