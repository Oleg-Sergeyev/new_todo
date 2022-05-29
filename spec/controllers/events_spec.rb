# frozen_string_literal: true

RSpec.describe EventsController, type: :controller do
  before(:each) { sign_in(user) }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:event_own) { create(:event, user: user) }

  describe 'GET' do
    it 'страница всех заданий открывается корректно' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'пользователь не может видеть не свои задания' do
      expect { get :show, params: { id: event.id } }.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'пользователь видит свои задания' do
      get :show, params: { id: event_own.id }
      expect(response).to have_http_status(:success)
    end
    it 'форма нового задания успешно создается' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'форма редактирования задания успешно создается' do
      get :edit, params: { id: event_own.id }
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST' do
    it 'задание успешно создано' do
      post :create, params: { event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end
    it 'задание не создано' do
      post :create, params: { event: attributes_for(:event_wrong) }
      expect(response).respond_to? :missing
    end
  end
  describe 'PATCH' do
    it 'свое задание успешно обновлено' do
      patch :update, params: { id: event_own.id, event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end
    it 'свое задание не обновлено' do
      patch :update, params: { id: event_own.id, event: attributes_for(:event_wrong) }
      expect(response).respond_to? :missing
    end
  end
  describe 'DELETE' do
    it 'свое задание успешно удалено' do
      delete :destroy, params: { id: event_own.id }
      expect(response).to have_http_status(:redirect)
    end
  end
  describe 'POST /journal' do
    before do
      cookies.permanent[:start_date] = DateTime.now.beginning_of_day
      cookies.permanent[:final_date] = DateTime.now.end_of_day
      cookies.permanent[:rows_count] = 10
    end
    it 'если переданы параметры журнала' do
      post :journal, params: { event: attributes_for(:event) }
      expect(response).to have_http_status(:success)
    end
  end
end
