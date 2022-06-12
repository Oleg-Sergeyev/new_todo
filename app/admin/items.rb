# frozen_string_literal: true

ActiveAdmin.register Item do
  menu false
  # menu priority: 4, label: 'Подзадания'
  belongs_to :event, optional: true
  actions :index, :show, :update, :edit, :destroy, :new, :create
  permit_params %i[id event user event_id name content done finished_at]
  config.action_items.delete_at(2)
  config.sort_order = 'name_asc'

  action_item :destroy, only: :show do
    link_to t('active_admin.resources.item.delete_model'),
            admin_event_item_path, data: { action: :destroy,
                                           method: :delete,
                                           confirm: 'Are you sure?' }, class: 'delete_link'
  end

  controller do
    def create
      create! do |format|
        format.html { redirect_to "/admin/events/#{resource.event_id}/items/#{resource.id}" } if resource.valid?
      end
    end

    def destroy
      # destroy! do |format|
      #   format.html { redirect_to "/admin/events/#{resource.event_id}" } if resource.valid?
      # end
      resource.delete
      redirect_to admin_event_path(resource.event_id)
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
