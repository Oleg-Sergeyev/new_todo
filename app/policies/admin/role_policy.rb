# frozen_string_literal: true

module Admin
  # class UserPolicy
  class RolePolicy < Admin::ApplicationPolicy
    def index?
      user.admin?
    end

    # class Scope
    class Scope < Scope
      def resolve
        user.admin? ? scope.all : scope.none
      end
    end
  end
end
