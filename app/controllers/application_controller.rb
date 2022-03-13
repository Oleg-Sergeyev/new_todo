# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # http_basic_authenticate_with name: 'prog', password: 'Fresh-Site'
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :dont_allow_admin_update_profile
  before_action :dont_allow_default_show_users

  def after_sign_in_path_for(user)
    user.admin? ? admin_root_path : root_path
  end

  def access_denied(exception)
    exception.sign_out
    redirect_to root_path
  end

  private

  # def dont_allow_admin_update_profile
  #   Rails.logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{params[:controller]}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  #   if ['devise/registrations'].include?(params[:controller]) && %w[update
  #                                                                   edit].include?(params[:action]) && current_user.admin?
  #     redirect_to root_path
  #   end
  # end

  def dont_allow_default_show_users
    redirect_to root_path if current_user && (['users'].include?(params[:controller]) && current_user.default?)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name file avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email avatar])
  end
end
