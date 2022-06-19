RSpec.describe 'admin_nmport_export', driver: :selenium_chrome, js: true	do
  let(:user) { create :admin_user }
  before :each do
    visit new_user_session_path
    fill_in 'input_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'submit_log_in'
  end
  describe 'index page' do
    subject do
      visit admin_import_eksport_polzovateley_path
    end

    it 'главная страница Отчетов' do
      subject
      expect(page).to have_text('Импорт/экспорт пользователей')
      expect(page).to have_css('#download_users')
      expect(page).to have_css('#upload_users')
      expect(page).to have_css('#uploads_form_excel')
    end
    it 'выставление значений дат и нажатие на выгрузку файла' do
      subject
      find('#download_users').click
      find('#upload_users').click
    end
  end
end
