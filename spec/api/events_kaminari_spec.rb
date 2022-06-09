# frozen_string_literal: true

require 'rails_helper'

describe Events, type: :api do
  before do
    FactoryBot.create_list(:event, 4, state: :created, created_at: '2022-04-23T01:32:50.809+03:00')
    FactoryBot.create_list(:event, 2, state: :finished, created_at: '2022-03-23T01:32:50.809+03:00')
  end
  describe 'GET /api/events' do
    it '2 задания(с любым статусом) на третьей странице' do
      get '/api/events?page=3&all=true'
      expect(json_dig('events').count).to eq(2)
    end
    it '2 задания(с любым статусом) на второй странице' do
      get '/api/events?page=2&all=true'
      expect(json_dig('events').count).to eq(2)
    end
    it '2 задания(со статусом finished) только на первой странице' do
      get '/api/events?page=1'
      expect(json_dig('events').count).to eq(2)
    end
    it '2 задания(со статусом finished, отсортированные) только на первой странице' do
      get '/api/events/created/asc?page=1'
      expect(json_dig('events').count).to eq(2)
    end
    it '2 задания(с любым статусом, отсортированные) на третьей странице' do
      get '/api/events/updated/desc?page=3&all=true'
      expect(json_dig('events').count).to eq(2)
    end
    it 'задание(с любым статусом, с наименьшей датой создания) на первой странице, на первом месте' do
      get '/api/events/created/asc?page=1&all=true'
      expect(json_dig('events').first['created_at']).to eq('2022-03-23T01:32:50.809+03:00')
    end
    it 'задание(с любым статусом, с наибольшей датой создания) на последней странице' do
      get '/api/events/created/asc?page=3&all=true'
      expect(json_dig('events').last['created_at']).to eq('2022-04-23T01:32:50.809+03:00')
    end
  end
end
