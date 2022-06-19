# frozen_string_literal: true

describe Admin::EventsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    @user_admin = FactoryBot.create(:user_admin)
    @event = FactoryBot.create(:event, user: @user)
    sign_in @user_admin
  end
  it 'создает новое задание' do
    post :create, params: { user: @user, event: @event }
    expect(Event.all.count).to eq(1)
  end
  it 'новое задание, может быть передано в работу' do
    expect(Event.first.may_start?).to be true
  end
  it 'новое задание, не может быть сразу выполнено' do
    expect(Event.first.may_complete?).to be false
  end
  it 'редактируемое со статусом created не может быть обновлено на статус finished' do
    @event.state = 'finished'
    patch :update, params: { id: @event.id, event: attributes_for(:event) }
    expect(Event.first.may_complete?).to be false
  end
end
