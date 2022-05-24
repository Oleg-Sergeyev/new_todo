# frozen_string_literal: true

include BCrypt

# FactoryBot.define do
#   factory :user do
#     pass = FFaker::Internet.password(8, 16)
#     sequence(:name) { |n| FFaker::Internet.user_name[0..10] + n.to_s }
#     sequence(:email) { |n| "person#{n + 10}@example.com" }
#     encrypted_password { Password.create(pass) }
#     password { pass }
#     #active { true }
#     role { create(:role) }
#     events_unffd_count { 0 }
#     items_unffd_count { 0 }
#     #password { 'admin1@example.com' }
#     #password_confirmation { pass }
#   end
# end

FactoryBot.define do
  factory :user do
    pass = FFaker::Internet.password(8, 16)
    sequence(:name) { |n| FFaker::Internet.user_name[0..10] + n.to_s }
    sequence(:email) { |n| "person#{n}@example#{rand(0..1000)}.com" }
    password { pass }
    #active { true }
    role { create(:role) }
    events_unffd_count { 0 }
    events_ffd_count { 0 }
    items_unffd_count { 0 }
    items_ffd_count { 0 }
    factory :user_wrong do
      pass = FFaker::Internet.password(8, 16)
      sequence(:name) { 'ы' }
      sequence(:email) { nil }
      password { pass }
      role { create(:role) }
      events_unffd_count { 0 }
      events_ffd_count { 0 }
      items_unffd_count { 0 }
      items_ffd_count { 0 }
    end
  end
end
