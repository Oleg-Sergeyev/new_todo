# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) do
    Role.new(name: 'Пользователь', code: :default)
  end

  it 'is valid' do
    expect(role).to be_valid
  end
end
