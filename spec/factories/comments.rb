FactoryBot.define do
  factory :comment do
    content { FFaker::HipsterIpsum.paragraph }
    user
    factory :comment_wrong do
      content { '2' }
      user { nil }
    end
  end
end
