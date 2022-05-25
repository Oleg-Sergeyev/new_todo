# frozen_string_literal: true

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
  context 'belongs_to связь' do
    let(:comment) { build(:comment) }
    let(:user) { create(:user) }
    it 'успешно работает' do
      expect(comment).to respond_to(:user)
      expect(comment.user).to be_instance_of(User)
    end
  end
  # Shoulda
  subject { build(:comment) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to belong_to(:user).counter_cache(true) }
  it { is_expected.to belong_to(:commentable) }
end
