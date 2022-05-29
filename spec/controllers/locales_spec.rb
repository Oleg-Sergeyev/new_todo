# frozen_string_literal: true

RSpec.describe LocalesController, type: :controller do
  describe 'POST' do
    it 'returns http success' do
      post :toggle
      expect(response).to have_http_status(:redirect)
      # get :toggle, params: { event: attributes_for(:event_wrong) }
      # expect(response).to have_http_status(:success)
    end
  end
end
