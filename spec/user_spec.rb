require_relative 'lib/user'
require_relative 'lib/services/user_generator'

RSpec.describe User do
  let(:some_user){ Services::UserGenerator.generate }
  let(:user) { User.new(some_user) }

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
      expect(user.email).to eq some_user[:email]
    end
    it :first_name do
      expect(user.first_name).to eq some_user[:first_name]
    end
    it :last_name do
      expect(user.last_name).to eq some_user[:last_name]
    end
    it :middle_name do
      expect(user.middle_name).to eq some_user[:middle_name]
    end
  end
  context 'Созданный пользователь содержит в поле "email"' do
    it 'электронный адрес' do
      expect(user.email).to match(/^\S+@\S+\.\S+$/)
    end
  end
end
