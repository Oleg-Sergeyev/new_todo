# frozen_string_literal: true

ActiveAdmin.register Item do
  actions :index, :show, :update, :edit, :destroy
  menu priority: 4, label: 'Подзадания'

  permit_params %i[id event user event_id name content done finished_at]

  config.sort_order = 'name_asc'

  index do
    id_column
    column 'Содержимое' do |item|
      link_to item.name.truncate(100), "/admin/items/#{item.id}"
    end
    column :done
    column :finished_at
    column 'Пользователь' do |item|
      tag.strong(User.find_by(id: Event.find_by(id: item.event_id).user_id).name)
    end
    column 'Event' do |item|
      link_to Event.find_by(id: item.event_id).name.truncate(30), "/admin/events/#{Event.find_by(id: item.event_id).id}"
    end
    actions
  end

  # controller do
  #   def self.my_custom_filter_eq(value)
  #     User.id(value).events.items # or probably a more complex query that uses the value inputted by the admin user
  #   end
  # end

  # def self.my_custom_filter_eq(value)
  #   User.id(value).events.items # or probably a more complex query that uses the value inputted by the admin user
  # end

  # def self.ransackable_scopes(_auth_object = nil)
  #   %i(my_custom_filter_eq)
  # end

  form partial: 'form_item_edit'

  filter :name
  filter :done
  # , as: :radio, collection: [['Yes', 'yes', { checked: true }], ['No', 'no', { checked: false }]], include_blank: false
  filter :finished_at
  filter :event
  # filter User.includes(:events).pluck(:name).to_s
  # filter :user_name_eq, as: :select, collection: -> { User.pluck(:id, :name) }
  # filter :my_custom_filter, as: :select, collection: -> { User.pluck(:id, :name) }, filters: [:eq]
end
