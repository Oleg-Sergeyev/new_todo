# frozen_string_literal: true

# module EventFiltersHelper
module EventFiltersHelper
  extend Grape::API::Helpers

  def all?
    ActiveRecord::Type::Boolean.new.cast(params[:all])
  end

  def events_scope(all, attribute = nil, order = nil)
    scope =  order ? Event.includes(user: :role).order(attribute => order) : Event.includes(user: :role).order(:id)
    all ? scope : scope.where(state: :finished)
  end
end
