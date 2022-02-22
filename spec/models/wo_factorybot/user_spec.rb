# frozen_string_literal: true

require 'rails_helper'
include BCrypt

RSpec.describe User, type: :model do
  before do
    Role.create(name: 'Пользователь', code: :default)
  end
  let(:user) do
    User.new(name: FFaker::Internet.user_name[0...16], email: 'person@example.com',
             encrypted_password: Password.create('password'), password: 'password')
  end

  it 'is valid' do
    expect(user).to be_valid
  end
end
