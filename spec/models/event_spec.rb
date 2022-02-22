# frozen_string_literal: true

require 'rails_helper'
include BCrypt

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.create :event }
  it 'is valid' do
    expect(event).to be_valid
  end
end
