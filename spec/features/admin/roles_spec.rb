RSpec.describe Admin::RolesController, driver: :selenium_chrome, js: true	do
  let(:user) { create :admin_user }
  before :each do
    visit new_user_session_path
    fill_in 'input_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'submit_log_in'
  end
  describe 'index page' do
    subject do
      visit admin_roles_path
    end

    it 'главная страница ролей' do
      subject
      expect(page).to have_text('Roles')
    end
    it 'выставление значений дат и нажатие на выгрузку файла' do
      subject
      find(:xpath, "//a[@href='/admin/roles/new']").click
      fill_in 'role_name', with: 'Редактор новостей'
      fill_in 'role_code', with: 'default'
      click_button 'button'
    end
  end
end
