# frozen_string_literal: true

# module Currency
module Currency
  extend ActiveSupport::Concern

  def currency_world
    Types::String.default('RUB').enum('RUB', 'USD', 'EUR')
  end
end
