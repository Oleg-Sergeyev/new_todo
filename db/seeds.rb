# frozen_string_literal: true

Comment.destroy_all
Seo.destroy_all
Item.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all

default_role = Role.create!(name: 'Пользователь', code: :default)
admin_role = Role.create!(name: 'Администратор', code: :admin)

hash_users = 10.times.map do
  email = FFaker::Internet.safe_email
  {
    name: email,
    email: email,
    password: email,
    role: default_role,
    active: [true, false].sample,
    events_unffd_count: 0,
    events_ffd_count: 0,
    items_unffd_count: 0,
    items_ffd_count: 0
  }
end

users = User.create! hash_users

hash_events = 20.times.map do
  {
    name: FFaker::HipsterIpsum.phrase,
    content: FFaker::HipsterIpsum.paragraphs,
    user: users.sample,
    done: [true, false].sample
  }
end

events = Event.create! hash_events
hash_items = 200.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    event: events.sample,
    done: [true, false].sample
  }
end
Item.create! hash_items

hash_comments = 200.times.map do
  commentable = (rand(2) == 1 ? events : users).sample
  {
    content: FFaker::Lorem.paragraph,
    user: users.sample,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end

comments = Comment.create! hash_comments

hash_seos = 200.times.map do
  promoted = (rand(2) == 1 ? comments : users).sample
  {
    # comment: comments.sample,
    title: FFaker::Lorem.sentence(1),
    description: FFaker::Lorem.sentence(10),
    keywords: FFaker::Lorem.sentence(12),
    promoted_id: promoted.id,
    promoted_type: promoted.class.to_s
  }
end

Seo.create! hash_seos

# User.create!(name: 'admin@example.com', email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
hash_user =
  {
    name: 'admin1@example.com',
    email: 'admin1@example.com',
    role: admin_role,
    active: true,
    events_unffd_count: 0,
    events_ffd_count: 0,
    items_unffd_count: 0,
    items_ffd_count: 0,
    password: 'admin1@example.com',
    password_confirmation: 'admin1@example.com'
  }

User.create! hash_user

Event.find_each do |date|
  date.update(created_at: DateTime.now - rand(0..5).day)
end
