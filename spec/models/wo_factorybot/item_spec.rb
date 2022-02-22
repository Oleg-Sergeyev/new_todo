# frozen_string_literal: true

require 'rails_helper'

include BCrypt

RSpec.describe Item, type: :model do
  before do
    Role.create(name: 'Пользователь', code: :default)
    User.create(name: FFaker::Internet.user_name[0...16], email: 'person@example.com',
                encrypted_password: Password.create('password'), password: 'password',
                id: 1, items_ffd_count: 0, events_unffd_count: 0)
    Event.create(name: FFaker::HipsterIpsum.phrase, id: 1, user_id: 1)
  end
  let(:item) { Item.new(name: FFaker::HipsterIpsum.paragraph, event_id: 1) }
  it 'is valid with valid attributes' do
    expect(item).to be_valid
  end
end
