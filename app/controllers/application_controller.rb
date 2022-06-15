# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :dont_allow_admin_update_profile
  before_action :dont_allow_default_show_users
  before_action :check_user_state
  before_action do
    I18n.locale = session[:locale]
  end
  add_flash_types :info, :error, :warning

  def after_sign_in_path_for(user)
    user.admin? ? admin_root_path : root_path
  end

  def destroy_admin_user_session_path
    session[:current_admin] = nil
    root_path
  end

  def access_denied(_exception)
    sign_out
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

  def check_user_state
    return unless user_signed_in?

    case current_user.state
    when 'banned'
      log_out('messages.user_has_been_banned')
    when 'archived'
      log_out('messages.user_has_been_moved')
    end
  end

  def log_out(message)
    sign_out
    redirect_to new_user_session_path, notice: t(message).capitalize
  end

  def dont_allow_default_show_users
    redirect_to root_path if current_user && (['users'].include?(params[:controller]) && current_user.default?)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name file avatar email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email avatar password])
  end
end
