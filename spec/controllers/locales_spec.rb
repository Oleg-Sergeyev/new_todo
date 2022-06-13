# frozen_string_literal: true

RSpec.describe LocalesController, type: :controller do
  describe 'POST' do
    before do
      session[:locale] = :en
    end
    it 'returns http success' do
      post :toggle
      expect(response).to have_http_status(:redirect)
      expect(I18n.locale).to eq(:ru)
    end
  end
end
