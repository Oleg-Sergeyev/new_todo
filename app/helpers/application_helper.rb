# frozen_string_literal: true

# module ApplicationHelper
module ApplicationHelper
  def current_user_avatar?
    user_signed_in? && current_user.avatar.attached?
  end

  def current_date
    Date.current.to_s
  end

  def language_link_name
    #session[:locale] == I18n.default_locale.to_s ? 'EN' : 'RU'
    locale == I18n.default_locale.to_s ? 'EN' : 'RU'
  end

  def locale
    lang = session.fetch(:locale, I18n.default_locale.to_s)
    unless I18n.available_locales.map(&:to_s).include? lang

      lang = I18n.default_locale.to_s
    end
    lang
  end

  # def count_title(klass, count)
  #   count ||= 0
  #   number = count.to_i.digits.reverse.last.to_i
  #   count_name = 'many' if (5..9).include?(number) || number.zero?
  #   count_name = 'others' if (2..4).include? number
  #   count_name = 'one' if number == 1
  #   "#{count} #{t("activerecord.attributes.#{klass.name.downcase}.#{count_name}")}"
  # end
end
