# frozen_string_literal: true

ActiveAdmin.register Event do
  menu priority: 3, label: I18n.t('active_admin.label.main_events').capitalize
  show title: proc { |event| event.name.truncate(50) }
  permit_params %i[id user_id name content done finished_at event_id state]
  actions :index, :show, :update, :edit, :new, :destroy
  before_action :event_state, only: :update

  action_item :new_item, only: :show do
    link_to(I18n.t('active_admin.resources.item.new_model'),
            new_admin_event_item_path(resource.id),
            data: { action: :create, method: :get })
  end

  index do
    id_column
    column I18n.t('active_admin.content') do |event|
      tag.strong((link_to event.name.truncate(50), "/admin/events/#{event.id}")) +
        tag.br +
        event.content.truncate(150)
    end
    column :done
    column :user
    actions
  end

  filter :id
  filter :name
  filter :content
  filter :done
  filter :finished_at

  form partial: 'form_event_edit'

  show title: proc { |event| event.name.truncate(50) } do
    attributes_table do
      row :id
      row :name
      row :content
      row I18n.t('active_admin.user').capitalize do
        resource.user.name
      end
      row I18n.t('active_admin.label.state_event') do
        resource.state
      end
      row :finished_at do
        event.finished_at.nil? ? t('active_admin.info.still_in_work').capitalize : event.finished_at
      end
      row :updated_at
      row :created_at
      row I18n.t('active_admin.file').capitalize do
        link_to(I18n.t('active_admin.resources.event.download_model'),
                admin_events_path(q: { id_eq: resource.id }, format: :csv))
      end
    end

    panel t('active_admin.items').capitalize do
      scope = resource.items.order(created_at: :desc)
      table_for scope do
        column :id
        # column link_to(:name, edit_event_item(:id), class: 'link-dark', style: 'font-weight: bolder;')
        column :name do |p|
          link_to p.name.truncate(100), "/admin/events/#{resource.id}/items/#{p.id}"
        end
        column :done
        column :finished_at
        column :updated_at
        column :created_at
        column I18n.t('active_admin.actions') do |item|
          links = []
          links << link_to('Show', "/admin/events/#{resource.id}/items/#{item.id}")
          links << link_to('Edit', "/admin/events/#{resource.id}/items/#{item.id}/edit")
          links << link_to('Delete', "/admin/events/#{resource.id}/items/#{item.id}",
                           data: { action: :destroy, method: :delete, confirm: 'Are you sure?' })
          links.join(' ').html_safe
        end
      end
    end
  end

  controller do
    def event_state
      case params[:event][:state]
      when 'created'
        resource.may_start? ? return : redirect(resource.id)
      when 'pending'
        resource.may_pend? ? return : redirect(resource.id)
      when 'running'
        resource.may_start? ? return : redirect(resource.id)
      when 'finished'
        resource.may_complete? ? return : redirect(resource.id)
      else
        redirect(resource.id)
      end
    end

    def redirect(id)
      redirect_to edit_admin_event_path(id),
                  flash: { error: t('active_admin.messages.state_change_error').capitalize }
    end
  end
end
