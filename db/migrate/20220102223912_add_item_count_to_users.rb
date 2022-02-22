# frozen_string_literal: true

class AddItemCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :items_ffd_count, :integer
    add_column :users, :items_unffd_count, :integer
  end
end
