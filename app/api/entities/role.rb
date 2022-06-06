# frozen_string_literal: true

# module Entities
module Entities
  # class Role
  class Role < Grape::Entity
    root 'roles', 'role'

    expose :code
  end
end
