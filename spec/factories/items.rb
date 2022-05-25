# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { FFaker::HipsterIpsum.paragraph }
    done { false }
    event

    factory :item_wrong do
      name { nil }
      done { false }
      event { nil }
    end
  end
end
