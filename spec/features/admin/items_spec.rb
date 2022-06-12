require 'rails_helper'

RSpec.describe Admin::ItemsController, driver: :selenium_chrome, js: true do
  let(:user_admin) { create(:user_admin) }
  before :each do
    visit new_user_session_path
    fill_in 'input_email', with: user_admin.email
    fill_in 'user_password', with: user_admin.password
    click_button 'submit_log_in'
  end
  context 'создание подзадания' do
    let(:user) { create(:user) }
    let(:event) { create(:event, name: 'New Task', user: user) }
    let(:item) { create(:item, name: 'New Item for main Task', event: event) }
    it 'успешно отрабатывает' do
      event
      item
      visit new_admin_event_item_path(event.id)
      fill_in 'item_name', with: item.name
      check 'item_done', with: 1
      click_button 'button'
      expect(page).to have_content(item.name)
      expect(current_path).to match /\/admin\/events\/\d+\/items\/\d+/
    end
  end
  context 'детальная страница задания c подзаданием' do
    let(:user) { create(:user) }
    let(:event) { create(:event, name: 'New Task', user: user) }
    let(:item) { create(:item, name: 'New Item for main Task', event: event) }
    it 'успешный переход' do
      event
      item
      visit admin_event_path(event.id)
      expect(page).to have_current_path admin_event_path(event.id), ignore_query: true
      expect(page).to have_content('New Task')
      expect(page).to have_content('New Item for main Task')
    end
  end
  context 'удаление подзадания' do
    let(:user) { create(:user) }
    let(:event) { create(:event, name: 'New Task', user: user) }
    let(:item) { create(:item, name: 'New Item for main Task', event: event) }
    it 'успешно отрабатывает' do
      event
      item
      visit admin_event_item_path(event_id: event.id, id: item.id)
      page.accept_confirm do
        find(".delete_link[href='/admin/events/#{event.id}/items/#{item.id}']").click
      end
      expect(page).not_to have_content(item.name)
      expect { item.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
