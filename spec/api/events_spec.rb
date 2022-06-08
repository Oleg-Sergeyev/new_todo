# frozen_string_literal: true

require 'rails_helper'

describe Events, type: :api do
  before do
    create(:event)
    create(:event, state: :finished)
  end
  describe 'GET /api/events' do
    let(:event_json) {
      include(
        'id' => a_value > 0,
        'name' => be_an(String),
        'content' => be_an(String),
        'state' => be_an(String),
        'created_at' => be_an(String),
        'updated_at' => be_an(String),
        'finished_at' => be_an(String),
        'user' => hash_including(
          'email' => a_kind_of(String),
          'name' => a_kind_of(String)
        )
      )
    }
    it 'return success' do
      get '/api/events'
      expect(last_response.status).to eq(200)
      # binding.pry
      expect(json_dig('events').count).to eq(1)
    end

    it 'с параметром all выводятся все события' do
      get '/api/events?all=true'
      expect(json_dig('events').count).to eq(2)
    end

    it 'отдает правильную структуру' do
      get '/api/events'
      expect(json_dig('events')).to include(event_json)
    end
  end
  describe 'GET /api/events/:id' do
    let(:event) { create(:event) }
    let(:event_json) {
      include(
        'id' => a_value > 0,
        'name' => be_an(String),
        'content' => be_an(String),
        'state' => be_an(String),
        'finished_at' => a_value
        )
    }
    it '/api/events/:id' do
      get "/api/events/#{event.id}"
      expect(last_response.status).to eq(200)
    end
  end
end
