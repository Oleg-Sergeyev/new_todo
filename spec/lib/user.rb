require 'faker'

class User
  attr_reader :email, :first_name, :last_name, :middle_name

  def initialize(email:, first_name:, last_name:, middle_name:)
    @email = email
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
  end

  def self.generate
    { email: FFaker::Internet.safe_email,
      first_name: FFaker::Internet.first_name,
      last_name: FFaker::Internet.last_name,
      middle_name: FFaker::Internet.middle_name }
  end
end
