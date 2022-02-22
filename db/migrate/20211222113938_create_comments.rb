# frozen_string_literal: true

# class CreateComments
class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, comment: 'Комментарии пользователей' do |t|
      t.text :content, comment: 'Содержимое сообщения'
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
