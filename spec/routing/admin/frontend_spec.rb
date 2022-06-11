# frozen_string_literal: true

RSpec.describe '', type: :routing do
  it 'GET admin/events соотвествует admin/events#index' do
    expect(get: '/admin/events').to route_to('admin/events#index')
  end
end
