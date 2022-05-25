# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { FFaker::CheesyLingo.title }
    user { create(:user) }
    commentable_id { user }
    commentable_type { 'User' }
    factory :comment_wrong do
      content { '2' }
      user { nil }
    end
  end
end
