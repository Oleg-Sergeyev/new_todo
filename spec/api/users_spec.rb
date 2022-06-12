# frozen_string_literal: true

require 'rails_helper'

describe Users, type: :api do
  before do
    create(:user, state: :banned)
    create(:user, state: :active)
    create(:user, state: :active)
  end
  describe 'GET /api/users' do
    let(:user_json) {
      include(
        'id' => a_value > 0,
        'name' => be_an(String),
        'role' => be_an(String),
        'state' => be_an(String)
      )
    }
    it 'return success' do
      get '/api/users'
      expect(last_response.status).to eq(200)
      expect(json_dig('users').count).to eq(3)
    end

    it 'с параметром active выводятся все активные пользователи' do
      get '/api/users/state/active'
      expect(json_dig('users').count).to eq(2)
    end

    it 'с параметром banned выводятся все забаненные пользователи' do
      get '/api/users/state/banned'
      expect(json_dig('users').count).to eq(1)
    end

    it 'отдает правильную структуру' do
      get '/api/users'
      expect(json_dig('users')).to include(user_json)
    end
  end
  describe 'GET /api/users/id/:id' do
    let(:user) { create(:user) }
    let(:user_json) {
      include(
        'id' => a_value > 0,
        'name' => be_an(String),
        'role' => be_an(String),
        'state' => be_an(String)
      )
    }
    it '/api/users/id/:id' do
      get "/api/users/id/#{user.id}"
      expect(last_response.status).to eq(200)
    end
  end
end
