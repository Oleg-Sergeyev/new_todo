# frozen_string_literal: true

RSpec.describe '', type: :routing do
  it 'GET /about соотвествует about#index' do
    expect(get: '/about').to route_to('about#index')
  end
  it 'POST /toggle соотвествует locales#toggle' do
    expect(post: '/toggle').to route_to('locales#toggle')
  end
  it 'GET / главная страница соотвествует home#index' do
    expect(get: '/').to route_to('home#index')
  end
  it 'POST /events страница заданий соотвествует events#create' do
    expect(post: '/events').to route_to('events#create')
  end
  it 'GET /events/new страница заданий соотвествует events#new' do
    expect(get: '/events/new').to route_to('events#new')
  end
  it 'GET /events/:id/edit страница заданий соотвествует events#edit' do
    expect(get: '/events/1/edit').to route_to('events#edit', id: '1')
  end
  it 'GET /events/:id страница заданий соотвествует events#show' do
    expect(get: '/events/1').to route_to('events#show', id: '1')
  end
  it 'PUT /events/:id страница заданий соотвествует events#update' do
    expect(put: '/events/1').to route_to('events#update', id: '1')
  end
  it 'DELETE /events/:id страница заданий соотвествует events#destroy' do
    expect(delete: '/events/1').to route_to('events#destroy', id: '1')
  end
  xit 'GET /events/page/:id страница заданий соотвествует events#index' do
    expect(get: '/events/page/1').to route_to('events#index', id: '1')
  end
end
