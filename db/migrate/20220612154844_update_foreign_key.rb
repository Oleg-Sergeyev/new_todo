class UpdateForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :events, :users
    add_foreign_key :events, :users, on_delete: :cascade
  
    remove_foreign_key :items, :events
    add_foreign_key :items, :events, on_delete: :cascade

    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, on_delete: :cascade
  end
end
