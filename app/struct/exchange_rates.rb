# frozen_string_literal: true

# class ExchangeRates
class ExchangeRates < Dry::Struct
  
  #attribute :date, Types::DateTime
  attribute :char_code, Types::String
  attribute :value, Types::Float

  def self.valutes
    json = JSON.parse(HTTParty.get('https://www.cbr-xml-daily.ru/daily_json.js').body)
    json['Valute'].reduce({}) { |h, (k, v)| h[k.upcase] = v['Value']; h }
  end

  # valutes.each do |k, v|
  #   define_method k do
  #     v
  #   end
  # end
end
