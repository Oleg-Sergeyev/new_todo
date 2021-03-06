# frozen_string_literal: true

class AddUserAuthenticationToken < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :authentication_token, :string
    add_index  :users, :authentication_token, unique: true
  end
end
