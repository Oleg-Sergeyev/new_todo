require 'rails_helper'

describe ApplicationHelper, type: :helper do
  it :current_date do
    expect(helper.current_date).to eq Date.current.to_s
  end
  context :language_link_name do
    it 'локаль по умолчанию' do
      expect(helper.language_link_name).to eq 'EN'
    end
    it 'локаль установлена в ru' do
      session[:locale] = 'ru'
      expect(helper.language_link_name).to eq 'EN'
    end
    it 'локаль установлена в en' do
      session[:locale] = 'en'
      expect(helper.language_link_name).to eq 'RU'
    end
    it 'локаль установлена в pt' do
      session[:locale] = 'pt'
      expect(helper.language_link_name).to eq 'EN'
    end
  end
  context :current_user_avatar? do
    context 'когда пользователь не авторизован' do
      it 'возвращает ложь' do
        expect(helper.current_user_avatar?).to be_falsey
      end
    end
    context 'когда пользователь авторизован и с аватаркой' do
      let(:user) { create(:user_with_avatar) }
      before { sign_in(user) }
      it 'возвращается истина' do
        expect(helper.current_user_avatar?).to be_truthy
      end
    end
  end
end
