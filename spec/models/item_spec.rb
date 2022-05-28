# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe Item, type: :model do
  context 'в невалидном состоянии' do
    let(:item) { build(:item_wrong) }
    it 'когда пустое название' do
      expect(item.validate).to be_falsey
      error_message = 'Название подзадания обязательно для заполнения'
      expect(item.errors.full_messages).to include error_message
    end
    it 'когда отсутствует основное задание' do
      expect(item.validate).to be_falsey
      error_message = 'Основное задание не может отсутствовать'
      expect(item.errors.full_messages).to include error_message
    end
  end
  context 'в валидном состоянии' do
    let(:item) { create(:item) }
    it 'удовлетворяет валидациям' do
      expect(item).to be_valid
    end
  end
  # Shoulda
  subject { build(:item) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:event) }
end
