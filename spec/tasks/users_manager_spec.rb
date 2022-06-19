# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks
describe 'users manager task' do
  before do
    create(:role)
    create(:role_admin)
    create(:user, name: 'user1@example.com', email: 'user1@example.com', state: 'created')
    create(:user, name: 'admin2@example.com', email: 'admin2@example.com', state: 'created')
  end
  it 'пользователь user1@example.com удален, admin2@example.com обновлен' do
    Rake::Task['resque:users_manager'].invoke
    expect(User.find_by(email: 'user1@example.com')).to be_nil
    expect(User.find_by(email: 'admin2@example.com').state).to eq 'active'
  end
end
