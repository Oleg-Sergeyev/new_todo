require 'rails_helper'

RSpec.describe 'Вход в систему администрирования', driver: :selenium_chrome, js: true	do
  let(:admin_user) { create :admin_user }
  it 'происходит успешно' do
    visit new_user_session_path
    fill_in 'input_email', with: admin_user.email
    fill_in 'user_password', with: admin_user.password
    click_button 'submit_log_in'
    expect(current_path).to eq admin_root_path
    expect(page).to have_content('Пользователи')
  end
  context 'для обычного пользователя' do
    let(:user) { create :user }
    it 'происходит успешно' do
      visit new_user_session_path
      fill_in 'input_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'submit_log_in'
      expect(current_path).to eq root_path
      expect(page).to have_content('Мы создаем приложения на Ruby')
    end
    it 'администрирования завершается неудачей' do
      visit admin_root_path
      expect(page).to have_current_path new_user_session_path, ignore_query: true
    end
  end
end
