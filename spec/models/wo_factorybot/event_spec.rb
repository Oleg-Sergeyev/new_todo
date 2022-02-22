# frozen_string_literal: true

require 'rails_helper'
include BCrypt

RSpec.describe Event, type: :model do
  before do
    Role.create(name: 'Пользователь', code: :default)
    User.create(name: FFaker::Internet.user_name[0...16], email: 'person@example.com',
                encrypted_password: Password.create('password'), password: 'password', id: 1)
  end
  let(:event) { Event.new(name: FFaker::HipsterIpsum.phrase, user_id: 1) }
  it 'is valid with valid attributes' do
    expect(event).to be_valid
  end
end
