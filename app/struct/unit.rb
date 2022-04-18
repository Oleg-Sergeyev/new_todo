# frozen_string_literal: true

# class Unit
class Unit < Dry::Struct
  Currency = Types::String.default('RUB').enum('RUB', 'EUR', 'USD')

  attribute :name, Types::String
  attribute? :description, Types::String
  attribute :price, Types::Coercible::Float
  attribute :currency, Currency
  attribute? :attachments, Types::Array do
    attribute :name, Types::String
    attribute :url, Types::String
  end

  def course(valute_code)
    ExchangeRates.new(char_code: valute_code,
                      value: ExchangeRates.valutes[valute_code]).value
  end

  def change_price(valute)
    if currency == 'RUB' && valute == 'USD'
      attributes.merge!(price: (price / course(valute)).round(2))
    elsif currency == 'RUB' && valute == 'EUR'
      attributes.merge!(price: (price / course(valute)).round(2))
    elsif currency == 'USD' && valute == 'RUB'
      attributes.merge!(price: (price * course('USD')).round(2))
    elsif currency == 'EUR' && valute == 'RUB'
      attributes.merge!(price: (price * course('EUR')).round(2))
    elsif currency == 'USD' && valute == 'EUR'
      attributes.merge!(price: ((price * course('USD')) / course('EUR')).round(2))
    elsif currency == 'EUR' && valute == 'USD'
      attributes.merge!(price: ((price * course('EUR')) / course('USD')).round(2))
    end
    attributes.merge!(currency: valute)
  end
end
