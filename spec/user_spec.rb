require_relative 'lib/user'

RSpec.describe User do
  let(:user) {
    User.new(
      email: 'test@test.ru',
      first_name: 'Тест',
      last_name: 'Тестов',
      middle_name: 'Тестович'
    )
  }
  let(:some_user){
    User.generate
  }
  context 'содержит методы' do
    it :email do
      expect(user).to respond_to :email
    end
    it :first_name do
      expect(user).to respond_to :first_name
    end
    it :last_name do
      expect(user).to respond_to :last_name
    end
    it :middle_name do
      expect(user).to respond_to :middle_name
    end
  end

  context 'корректно возвращает' do
    it :email do
      expect(user.email).to eq 'test@test.ru'
    end
    it :first_name do
      expect(user.first_name).to eq 'Тест'
    end
    it :last_name do
      expect(user.last_name).to eq 'Тестов'
    end
    it :middle_name do
      expect(user.middle_name).to eq 'Тестович'
    end
  end
  context 'успешно генерирует' do
    it 'пользователя' do
      puts "USER = #{some_user}"
      expect(some_user[:email]).to include '@'
    end
  end
end
