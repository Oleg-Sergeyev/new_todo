# frozen_string_literal: true

# module EventsHelper
module EventsHelper
  extend Grape::API::Helpers

  def events_scope(all)
    scope = Event.includes(user: :role).order(:id)
    all ? scope : scope.where(state: :finished)
  end
end
