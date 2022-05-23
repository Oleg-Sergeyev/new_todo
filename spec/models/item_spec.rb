# frozen_string_literal: true

require 'rails_helper'

include BCrypt

# RSpec.describe Item, type: :model do
#   before do
#     Role.create(name: 'Пользователь', code: :default)
#     User.create(name: FFaker::Internet.user_name[0...16], email: 'person@example.com',
#                 encrypted_password: Password.create('password'), password: 'password',
#                 id: 1, items_ffd_count: 0, events_unffd_count: 0)
#     Event.create(name: FFaker::HipsterIpsum.phrase, id: 1, user_id: 1)
#   end
# end

RSpec.describe Item, type: :model do
  context 'в невалидном состоянии' do
    let(:item) { build(:item_wrong) }
    it 'когда пустое название' do
      expect(item.validate).to be_falsey
      error_message = I18n.t('activerecord.errors.messages.name_required_to_fill')
      expect(item.errors.full_messages).to include error_message
    end
    it 'когда отсутствует родитель' do
      expect(item.validate).to be_falsey
      error_message = I18n.t('activerecord.errors.messages.event_cannot_be_missing')
      expect(item.errors.full_messages).to include error_message
    end
  end
  context 'в валидном состоянии' do
    let(:item) { create(:item) }
    it 'удовлетворяет валидациям' do
      expect(item).to be_valid
    end
  end
end
