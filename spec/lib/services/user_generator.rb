require 'faker'

module Services
  class UserGenerator

    def self.user
      { email: FFaker::Internet.safe_email,
        first_name: FFaker::Internet.first_name,
        last_name: FFaker::Internet.last_name,
        middle_name: FFaker::Internet.middle_name }
    end
  end
end
