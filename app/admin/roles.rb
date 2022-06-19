# frozen_string_literal: true

ActiveAdmin.register Role do
  menu priority: 2, label: I18n.t('active_admin.label.roles').capitalize
  actions :index, :new, :show, :create, :update, :edit, :destroy
  permit_params %i[id name code]

  index do
    column :name do |role|
      link_to(role.name, edit_admin_role_path(role.id), class: 'link-dark', style: 'font-weight: bolder;')
    end
    column :actions do |role|
      links = []
      links << link_to('Delete', admin_role_path(role.id),
                       data: { action: :destroy,
                               method: :delete,
                               confirm: 'Are you sure?' }, class: 'delete_link')
      links.join(' ').html_safe
    end
  end

  form partial: 'form_role_edit'

  # Filters
  filter :id
  filter :name, as: :select, collection: -> { Role.pluck(:name) }
  filter :code, as: :select, collection: -> { Role.pluck(:code) }
end
