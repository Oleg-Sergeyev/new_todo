# frozen_string_literal: true

RSpec.describe EventsController, type: :controller do
  let(:user_admin) { create(:user_admin) }
  before(:each) { sign_in(user_admin) }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:event_own) { create(:event, user: user) }

  describe 'созданный пользователь' do
    it 'является администратором' do
      expect(user_admin).respond_to? :admin?
      expect(user_admin.role.code).to eq 'admin'
    end
    it 'является простым пользоателем' do
      expect(user.role.code).to eq 'default'
    end
  end
  describe 'Администратору доступно' do
    it 'отображение заданий всех пользователей' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'отображение любого задния, любого пользователя ' do
      get :show, params: { id: event_own.id }
      expect(response).to have_http_status(:success)
    end
    it 'создание своего задания успешно создается' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'форма редактирования задания успешно создается' do
      get :edit, params: { id: event_own.id }
      expect(response).to have_http_status(:success)
    end
  end
  describe 'PATCH' do
    it 'любого пользователя задание успешно обновлено' do
      patch :update, params: { id: event_own.id, event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end
  end
  describe 'DELETE' do
    it 'любого пользователя задание успешно удалено' do
      delete :destroy, params: { id: event_own.id }
      expect(response).to have_http_status(:redirect)
    end
  end
  describe 'POST' do
    it 'задание любому пользователю успешно создано' do
      post :create, params: { id: user.id, event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end
  end
end
