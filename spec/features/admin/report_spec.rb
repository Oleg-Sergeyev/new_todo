RSpec.describe 'admin_otchet', driver: :selenium_chrome, js: true	do
  let(:user) { create :admin_user }
  before :each do
    visit new_user_session_path
    fill_in 'input_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'submit_log_in'
  end
  describe 'index page' do
    subject do
      visit admin_otchet_path
    end

    it 'главная страница Отчетов' do
      subject
      expect(page).to have_text('Отчеты')
      expect(page).to have_css('#download_book')
      expect(page).to have_css('#download_users')
      (1..5).each do |n|
        expect(page).to have_css("#report_form_from_#{n}i")
        expect(page).to have_css("#report_form_to_#{n}i")
      end
    end
    it 'выставление значений дат и нажатие на выгрузку файла' do
      subject
      within '#report_form_from_3i' do
        find("option[value='31']").click
      end
      within '#report_form_from_2i' do
        find("option[value='12']").click
      end
      within '#report_form_from_1i' do
        find("option[value='2021']").click
      end
      within '#report_form_from_4i' do
        find("option[value='23']").click
      end
      within '#report_form_from_5i' do
        find("option[value='59']").click
      end
      within '#report_form_to_3i' do
        find("option[value='31']").click
      end
      within '#report_form_to_2i' do
        find("option[value='12']").click
      end
      within '#report_form_to_1i' do
        find("option[value='2022']").click
      end
      within '#report_form_to_4i' do
        find("option[value='23']").click
      end
      within '#report_form_to_5i' do
        find("option[value='59']").click
      end
      find('#download_users').click
    end
  end
end
