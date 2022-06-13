require 'rails_helper'

RSpec.describe LocalesController, driver: :selenium_chrome, js: true do
  context 'главная страница' do
    before do
      visit root_path
      find('button').click
      find('#navbarDropdown').click
      @text_before = find('#localization_link')[:text]
      find('#localization_link').click
      find('button').click
      find('#navbarDropdown').click
      @text_after = find('#localization_link')[:text]
    end
    it 'переключатель локали работает' do
      expect(@text_after).not_to eq @text_before
    end
  end
end
