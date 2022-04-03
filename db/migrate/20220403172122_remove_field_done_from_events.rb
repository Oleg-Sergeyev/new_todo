class RemoveFieldDoneFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :done
  end
end
