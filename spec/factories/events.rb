# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { FFaker::CheesyLingo.title }
    content { FFaker::CheesyLingo.sentence }
    user
    finished_at { FFaker::Time.datetime }
    factory :event_wrong, parent: :event do 
      name { nil }
      content { FFaker::CheesyLingo.sentence }
      user { nil }
    end
  end
end
