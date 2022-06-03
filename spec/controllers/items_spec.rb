# frozen_string_literal: true

RSpec.describe ItemsController, type: :controller do
  before(:each) { sign_in(user) }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:event_own) { create(:event, user: user) }
  let(:item) { create(:item) }
  let(:item_event) { create(:item, event: event_own) }
  describe 'GET /index' do
    it :shwo do
      get :show, params: { id: item_event.id, event_id: event_own.id }
      expect(response).to have_http_status(:success)
    end
    it 'показывается все подзадания пользователя' do
      get :index, params: { id: item_event.id, event_id: event_own.id }
      expect(response).to have_http_status(:success)
    end
    it 'форма нового подзадания успешно создается' do
      get :new, params: { event_id: event_own.id }
      expect(response).to have_http_status(:success)
    end
    it 'форма редактирования задания успешно создается' do
      get :edit, params: { id: item_event.id, event_id: event_own.id }
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST' do
    xit 'подзадание успешно создано' do
      post :create, params: { event_id: item.event_id, item: attributes_for(:item) }
      expect(response).to have_http_status(:success)
    end
    it 'подзадание не создано' do
      post :create, params: { item: attributes_for(:item_wrong) }
      expect(response).respond_to? :missing
    end
  end
  describe 'PATCH' do
    it 'свое подзадание успешно обновлено' do
      patch :update, params: { id: item.id, item: attributes_for(:item) }
      expect(response).to have_http_status(:redirect)
    end
    it 'свое подзадание не обновлено' do
      patch :update, params: { id: item.id, item: attributes_for(:item_wrong) }
      expect(response).respond_to? :missing
    end
  end
  describe 'DELETE' do
    it 'свое подзадание успешно удалено' do
      delete :destroy, params: { id: item.id, item: attributes_for(:item) }
      expect(response).to have_http_status(:redirect)
    end
  end
end
