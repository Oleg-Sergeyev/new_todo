# frozen_string_literal: true

module Entities
  # class EventIndex
  class EventIndex < Grape::Entity
    include ActionView::Helpers::TextHelper
    root 'events', 'event'

    expose :user, :id, :name, :content, :state, :created_at, :updated_at, :finished_at

    def name
      truncate(object.name)
    end

    def content
      truncate(object.content)
    end
  end
end
