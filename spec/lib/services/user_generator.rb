require 'faker'

module Services
  class UserGenerator

    def self.generate
      { email: Faker::Internet.safe_email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        middle_name: Faker::Name.middle_name }
    end
  end
end
