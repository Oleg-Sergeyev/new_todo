# frozen_string_literal: true

class AddEventAndItemCountsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :events_ffd_count, :integer
    add_column :users, :events_unffd_count, :integer
  end
end
