# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    #sequence(:name) { |n| "name#{n}" }
    name { 'Пользователь' }
    code { 'default' }
    factory :role_wrong do
      name { nil }
      code { 1 }
    end
    factory :role_admin do
      name { 'Администратор' }
      code { 'admin' }
    end
  end
end
