# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe Role, type: :model do
  context 'в невалидном состоянии' do
    let(:role) { build(:role_wrong) }
    it 'когда пустое название' do
      expect(role.validate).to be_falsey
      error_message = 'Название роли обязательно для заполнения'
      expect(role.errors.full_messages).to include error_message
    end
    it 'не соотвествие длине поля' do
      expect(role.code.size).to be < 2
    end
  end
  context 'в валидном состоянии' do
    let(:role) { create(:role) }
    it 'удовлетворяет валидациям' do
      expect(role.validate).to be true
    end
  end
  # Shoulda
  subject { build(:role) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to have_many(:users) }
end
