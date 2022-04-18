# frozen_string_literal: true

# module Currency
module Currency
  extend ActiveSupport::Concern

  def char_code
    Types::String.default('RUB').enum('RUB', 'USD', 'EUR')
  end
end
