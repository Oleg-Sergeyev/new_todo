require 'rails_helper'

# RSpec.describe Event, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Event, type: :model do
  # let(:event) { FactoryBot.create :event }
  # it 'is valid' do
  #   expect(event).to be_valid
  # end
  context 'в невалидном состоянии' do
    let(:event) { Event.new }
    it 'когда пустое название' do
      expect(event.validate).to be_falsey
      error_message = I18n.t('activerecord.errors.messages.name_required_to_fill')
      expect(event.errors.full_messages).to include error_message
    end
    it 'когда отсутствует владелец' do
      expect(event.validate).to be_falsey
      error_message = I18n.t('activerecord.errors.messages.user_cannot_be_missing')
      expect(event.errors.full_messages).to include error_message
    end
  end
  context 'в валидном состоянии' do
    let(:event) { Event.new(name: 'Название события', user: User.new) }
    it 'удовлетворяет валидациям' do
      expect(event).to be_valid
    end
  end
end
