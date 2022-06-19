# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    pass = FFaker::Internet.password(8, 16)
    sequence(:name) { |n| FFaker::Internet.user_name[0..10] + n.to_s }
    sequence(:email) { |n| "person#{n}@example#{rand(0..1000)}.com" }
    password { pass }
    role { create(:role) }
    # role {  if Role.find_by(code: 'default')
    #           Role.find_by(code: 'default')
    #         else
    #           create(:role)
    #         end
    #         }
    events_unffd_count { 0 }
    events_ffd_count { 0 }
    items_unffd_count { 0 }
    items_ffd_count { 0 }
    comments_count { 0 }
    factory :user_wrong do
      pass = FFaker::Internet.password(8, 16)
      sequence(:name) { 'ы' }
      sequence(:email) { nil }
      password { pass }
      role { create(:role) }
      # role {  if Role.find_by(code: 'default')
      #           Role.find_by(code: 'default')
      #         else
      #           create(:role)
      #         end
      #          }
      events_unffd_count { 0 }
      events_ffd_count { 0 }
      items_unffd_count { 0 }
      items_ffd_count { 0 }
      comments_count { 0 }
    end
    factory :user_admin do
      pass = 'admin1@example.com'
      name { "admin1@example#{rand(0..1000)}.com" }
      email { "admin1@example#{rand(0..1000)}.com" }
      password { pass }
      role { create(:role_admin) }
      # role {  if Role.find_by(code: 'admin')
      #           Role.find_by(code: 'admin')
      #         else
      #           create(:role)
      #         end
      #          }
      events_unffd_count { 0 }
      events_ffd_count { 0 }
      items_unffd_count { 0 }
      items_ffd_count { 0 }
      comments_count { 0 }
    end
    factory :admin_user, parent: :user do
      role { build(:role, name: :admin, code: :admin) }
    end
  end
end
