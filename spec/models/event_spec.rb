# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe Event, type: :model do
  context 'в невалидном состоянии' do
    let(:event) { Event.new }
    it 'когда пустое название' do
      expect(event.validate).to be_falsey
      error_message = 'Название задания обязательно для заполнения'
      expect(event.errors.full_messages).to include error_message
    end
    it 'когда отсутствует владелец' do
      expect(event.validate).to be_falsey
      error_message = 'Пользователь не может отсутствовать'
      expect(event.errors.full_messages).to include error_message
    end
  end
  context 'в валидном состоянии' do
    let(:event) { create(:event) }
    it 'удовлетворяет валидациям' do
      expect(event).to be_valid
    end
  end
  context 'belongs_to связь' do
    let(:event) { create(:event) }
    let(:user) { create(:user) }
    it 'успешно работает' do
      expect(event).to respond_to(:user)
      expect(event.user).to be_instance_of(User)
    end
    it 'успешно увеличивает счетчик в таблице users' do
      expect do
        user.events.create(attributes_for(:event))
      end.to change { user.events_count }.by 1
    end
  end
  # Shoulda
  subject { build(:event) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:user).counter_cache(true) }
  it { is_expected.to have_many(:items).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:nullify) }
  # commentators Комментаторов нет!
  # it { is_expected.to have_many(:commentators).through(:comments).source(:user) }
end
