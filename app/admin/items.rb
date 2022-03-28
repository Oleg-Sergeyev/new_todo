# frozen_string_literal: true

ActiveAdmin.register Item do
  menu false
  belongs_to :event, optional: true
  actions :index, :show, :update, :edit, :destroy, :new, :create
  # menu priority: 4, label: 'Подзадания'
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

  form partial: 'form_item_edit'

  filter :name
  filter :done
  filter :finished_at
  filter :event
end
