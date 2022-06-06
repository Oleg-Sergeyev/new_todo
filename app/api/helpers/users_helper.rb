# frozen_string_literal: true

# module EventsHelper
module UsersHelper
  extend Grape::API::Helpers

  def users_scope(all = nil)
    scope = User.includes(:role)
    all.nil? ? scope : scope.where(role_id: Role.find_by(code: all).id)
  end
end
