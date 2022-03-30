class AddStateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :state, :string, comment: 'Текущее состояние'
    remove_column :users, :active
  end
end
