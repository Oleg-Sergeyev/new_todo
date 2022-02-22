# frozen_string_literal: true

class AddPromotedfToSeos < ActiveRecord::Migration[6.1]
  def change
    add_reference :seos, :promoted, polymorphic: true, null: false
  end
end
