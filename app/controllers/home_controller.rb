# frozen_string_literal: true

# class HomeController
class HomeController < ApplicationController
  before_action :log_start, :log_params, :log_finish, only: :index

  def index
    # I18n.locale = params.fetch(:locale, I18n.default_locale)
    # I18n.locale = locale if I18n.available_locales.include?(locale)
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  def log_start
    Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  end

  alias log_finish log_start

  def log_params
    Rails.logger.info params.inspect
    Rails.logger.info params[:locale]
  end
end
