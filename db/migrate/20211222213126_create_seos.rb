# frozen_string_literal: true

# class CreateSeos
class CreateSeos < ActiveRecord::Migration[6.1]
  def change
    create_table :seos, comment: 'Теги для поисковых ситем' do |t|
      t.string :title, comment: 'Тег title'
      t.string :description, comment: 'Тег desription'
      t.string :keywords, comment: 'Тег keywords'

      t.timestamps
    end
  end
end
