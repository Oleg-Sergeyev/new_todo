# frozen_string_literal: true

class AddItemAndEventCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :events_count, :integer
    add_column :users, :items_count, :integer
  end
end
