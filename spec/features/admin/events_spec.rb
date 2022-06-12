require 'rails_helper'

RSpec.describe Admin::EventsController, driver: :selenium_chrome, js: true do
  let(:user_admin) { create(:user_admin) }
  before :each do
    visit new_user_session_path
    fill_in 'input_email', with: user_admin.email
    fill_in 'user_password', with: user_admin.password
    click_button 'submit_log_in'
  end
  context 'страница всех заданий' do
    it 'успешный переход' do
      @event = create(:event, user: create(:user))
      visit admin_events_path
      expect(page).to have_content('Events')
      expect(page).to have_content(@event.user.name)
      expect(page).to have_content(@event.name)
    end
  end
  context 'создание задания' do
    let(:user) { create(:user) }
    let(:event_attr) { attributes_for(:event, user: user) }
    it 'успешно отрабатывает' do
      user
      visit new_admin_event_path
      option = user.name
      find('#event_user_id').find(
           'option', text: /#{option}/i).select_option
      fill_in 'event_name', with: event_attr[:name]
      fill_in 'event_content', with: event_attr[:content]
      select 'created', from: 'event_state'
      click_button 'button'
      expect(page).to have_content(event_attr[:name])
      expect(current_path).to match /\/admin\/events\/\d+/
    end
  end
  context 'детальная страница задания' do
    let(:user) { create(:user) }
    let(:event) { create(:event, name: 'New Task', user: user) }
    it 'успешный переход' do
      event
      visit admin_event_path(event.id)
      expect(page).to have_current_path admin_event_path(event.id), ignore_query: true
      expect(page).to have_content('New Task')
    end
  end
  context 'редактирование задания' do
    let(:user) { create(:user) }
    let(:event) { create(:event, user: user) }
    it 'успешно отрабатывает' do
      option = 'running'
      event
      visit edit_admin_event_path(event.id)
      fill_in 'event_name', with: 'New task'
      fill_in 'event_content', with: 'NEW CONTENT!'
      find('#event_state').find(
        'option', text: /#{option}/i).select_option
      click_button 'button'
      expect(page).to have_content('New task')
      expect(page).to have_current_path admin_event_path(event.id), ignore_query: true
    end
  end
  context 'удаление задания' do
    it 'успешно отрабатывает' do
      event = create(:event)
      visit admin_event_path(event.id)
      page.accept_confirm do
        find(".delete_link[href='/admin/events/#{event.id}']").click
      end
      expect(page).not_to have_content(event.name)
      expect { event.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
