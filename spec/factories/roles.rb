FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "name#{n}" }
    sequence(:code) { |n| "code#{n}" }
    factory :role_wrong do
      sequence(:name) { nil }
      sequence(:code) { 1 }
    end
  end
end
