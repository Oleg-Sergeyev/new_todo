# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { FFaker::HipsterIpsum.phrase }
    content { FFaker::HipsterIpsum.paragraphs }
    done { false }
    user { create(:user) }
  end
end
