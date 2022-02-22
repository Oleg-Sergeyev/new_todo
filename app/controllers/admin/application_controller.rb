# frozen_string_literal: true

# class Admin::ApplicationController
module Admin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    layout 'layouts/admin/application'

    def current_page_info
      path = Rails.application.routes.recognize_path(request.env['PATH_INFO'])
      controller = path[:controller]
      action = path[:action]
      Rails.logger.info "******************Controller #{controller} Action #{action}*************************"
      Rails.logger.info "******************PARAMS #{params}*************************"
    end
  end
end
