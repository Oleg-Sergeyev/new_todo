require 'rails_helper'

RSpec.describe Admin::UsersController, driver: :selenium_chrome, js: true do
  let(:user) { create :admin_user }
  before :each do
    visit new_user_session_path
    fill_in 'input_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'submit_log_in'
  end
  context 'индексная страница' do
    it 'успешный переход' do
      visit admin_users_path
      expect(page).to have_content('Пользователи')
    end
    it 'успешно отражает нового пользователя' do
      create(:user, name: 'test.user')
      visit admin_users_path
      expect(page).to have_content('test.user')
    end
  end
  context 'детальная страница' do
    let(:default_user) { create(:user, name: 'test.user') }
    it 'успешный переход' do
      visit admin_user_path(default_user)
      expect(page).to have_current_path admin_user_path(default_user), ignore_query: true
      expect(page).to have_content('test.user')
    end
  end
  context 'создание записи' do
    let(:role) { create(:role, name: 'new_role') }
    let(:user_attr) { attributes_for(:user, role: role) }
    it 'успешно отрабатывает' do
      role
      visit new_admin_user_path
      fill_in 'user_email', with: user_attr[:email]
      fill_in 'user_name', with: user_attr[:name]
      select user_attr[:role].name, from: 'user_role_id'
      fill_in 'user_password', with: user_attr[:password]
      fill_in 'user_password_confirmation', with: user_attr[:password]
      click_button 'button'
      expect(page).to have_content(user_attr[:email])
      expect(page).to have_content(user_attr[:name].downcase)
      expect(current_path).to match /\/admin\/users\/\d+/
    end
  end
  context 'редактирование записи' do
    let(:default_user) { create(:user, name: 'test.user') }
    it 'успешно отрабатывает' do
      visit edit_admin_user_path(default_user)
      fill_in 'user_email', with: 'test@test.ru'
      click_button 'button'
      expect(page).to have_content('test@test.ru')
      expect(page).to have_current_path admin_user_path(default_user), ignore_query: true
    end
  end
  context 'удаление записи' do
    it 'успешно отрабатывает' do
      delete_user = create(:user, email: 'test_user@example.com')
      visit admin_users_path
      page.accept_confirm do
        find(".delete_link[href='/admin/users/#{delete_user.id}']").click
      end
      expect(page).not_to have_content('test_user@example.com')
      expect { delete_user.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
