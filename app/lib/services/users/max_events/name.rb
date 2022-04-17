# frozen_string_literal: true

class Services::Users::MaxEvents::Name
  include Callable
  extend Dry::Initializer

  param :max_count, default: proc { 3 }

  def call
    Queries::Users::MaxEvents.call(max_count).map(&:name)
  end
end
