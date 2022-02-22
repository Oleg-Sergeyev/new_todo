# frozen_string_literal: true

module ApplicationHelper
  def current_date
    Date.current.to_s
  end

  def language_link_name
    session[:locale] == I18n.default_locale.to_s ? 'EN' : 'RU'
  end

  def count_title(klass, count)
    count ||= 0
    number = count.to_i.digits.reverse.last.to_i
    count_name = 'many' if (5..9).include?(number) || number.zero?
    count_name = 'others' if (2..4).include? number
    count_name = 'one' if number == 1
    "#{count} #{t("activerecord.attributes.#{klass.name.downcase}.#{count_name}")}"
  end
end
