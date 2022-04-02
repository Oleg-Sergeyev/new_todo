# frozen_string_literal: true

ActiveAdmin.register Item do
  menu false
  # menu priority: 4, label: 'Подзадания'
  belongs_to :event, optional: true
  actions :index, :show, :update, :edit, :destroy, :new, :create
  permit_params %i[id event user event_id name content done finished_at]

  config.sort_order = 'name_asc'

  controller do
    def create
      create! do |format|
        format.html { redirect_to "/admin/events/#{resource.event_id}/items/#{resource.id}" } if resource.valid?
      end
    end

    def destroy
      destroy! do |format|
        format.html { redirect_to "/admin/events/#{resource.event_id}" } if resource.valid?
      end
    end
  end

  show title: proc { |item| item.name.truncate(50) } do
    attributes_table do
      row :name
      row :done
      row :finished_at do
        item.finished_at.nil? ? t('active_admin.info.still_in_work').capitalize : item.finished_at
      end
      row :created_at
      row :updated_at
      row t('active_admin.label.parent_event').capitalize do
        resource.event
      end
    end
  end

  form partial: 'form_item_edit'

  filter :name
  filter :done
  filter :finished_at
  filter :event
end
