require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'в невалидном состоянии' do
    let(:comment) { build(:comment_wrong) }
    it 'когда пользователь отсутствует' do
      expect(comment.validate).to be_falsey
      error_message = 'Пользователь не может отсутствовать'
      expect(comment.errors.full_messages).to include error_message
    end
    it 'не соотвествие длине поля' do
      expect(comment.content.size).to be < 2
    end
  end
  context 'в валидном состоянии' do
    let(:comment) { build(:comment) }
    it 'удовлетворяет валидациям' do
      expect(comment.validate).to be true
    end
  end
end
