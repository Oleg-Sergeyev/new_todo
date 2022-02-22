# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "name#{n}" }
    sequence(:code) { |n| "code#{n}" }
  end
end
