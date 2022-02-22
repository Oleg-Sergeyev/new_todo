# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      EventsScopeService.call(user, scope)
    end
  end

  def index?
    user
  end

  def show?
    record.user_id == user&.id || user&.admin?
  end

  def update?
    record.user_id == user&.id || user&.admin?
  end

  def destroy?
    record.user_id == user&.id || user&.admin?
  end
end
