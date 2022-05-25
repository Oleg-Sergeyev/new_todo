class ChangeUsersCommentsCount < ActiveRecord::Migration[6.1]
  def change
    change_column :users,
                  :events_count,
                  :integer,
                  comment: 'Счетчик событий пользователя (belongs_to)',
                  default: 0
    add_column :users, 
               :comments_count,
               :integer,
               comment: 'Счетчик комментариев пользователя (belongs_to)',
               default: 0
  end
end
