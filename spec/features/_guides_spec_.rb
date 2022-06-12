require 'rails_helper'

RSpec.describe 'При обращении', driver: :selenium_chrome, js: true do
  context 'по адресу https://guides.rubyonrails.org/' do
    it 'возвращается сообщение об успешной загрузке' do
      visit 'https://guides.rubyonrails.org/'
      expect(page).to have_content('Ruby on Rails Guides')
    end
  end
end
