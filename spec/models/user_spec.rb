# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'в невалидном состоянии' do
    let(:user_wrong) { build(:user_wrong) }
    it 'когда электронная почта не заполнена' do
      expect(user_wrong.validate).to be_falsey
      error_message = 'Эл.почта обязательна для заполнения'
      expect(user_wrong.errors.full_messages).to include error_message
    end
    it 'когда имя пользователя меньше требуемой длины' do
      expect(user_wrong.validate).to be_falsey
      error_message = 'Имя пользователя слишком коротко'
      expect(user_wrong.errors.full_messages).to include error_message
    end
  end
  context 'в валидном состоянии' do
    let(:user) { create(:user) }
    it 'удовлетворяет валидациям' do
      expect(user).to be_valid
    end
  end
end
