# frozen_string_literal: true

# class EventsFilter
class EventsFilter
  attr_accessor :user, :scope, :data_scope

  def initialize(scope, user)
    @user = user
    @scope = scope
    @data_scope = data
  end

  def data
    return scope.all if @user.admin?
    return scope.where(user: @user) if @user.default?
  end

  # scope :role, -> { where("@user.admin?") }

  # def resolve
  #   if user.admin?
  #     scope.all
  #   elsif user.premium?
  #     scope.where(...)
  #   else
  #     scope.where(...)
  #   end
  # end

  # def resolve
  #   user.admin? ? scope.all : scope.where(user: user)
  # end
end
