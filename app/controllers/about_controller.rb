# frozen_string_literal: true

class AboutController < ApplicationController
  before_action :log_start, :log_params, :log_finish, only: %i[show index]

  def index; end

  def log_start
  end

  alias log_finish log_start

  def log_params
    Rails.logger.info params.inspect
    Rails.logger.info params[:locale]
  end
end
