# frozen_string_literal: true

include BCrypt

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| FFaker::Internet.user_name[0..10] + n.to_s }
    sequence(:email) { |n| "person#{n + 10}@example.com" }
    encrypted_password { Password.create(FFaker::Internet.password) }
    password { FFaker::Internet.password }
    active { true }
    role { create(:role) }
    events_unffd_count { 0 }
    items_unffd_count { 0 }
    password { 'admin1@example.com' }
    password_confirmation { 'admin1@example.com' }
  end
end
