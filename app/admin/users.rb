# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 2, label: 'Пользователи сайта'
  permit_params %i[email name active role_id password password_confirmation]
  config.sort_order = 'name_asc'

  index do
    # selectable_column
    # column :id, &:id
    column(:avatar, width: 100) do |user|
      if user.avatar.attached?
        image_tag user.avatar.variant(resize: '30x30'), class: 'img-fluid rounded-circle'
      else
        tag.i(class: 'fa fa-user-circle-o', style: 'font-size:28px; color: rgb(63 67 70)')
      end
    end
    column :name do |user|
      link_to(user.name, edit_admin_user_path(user.id), class: 'link-dark', style: 'font-weight: bolder;')
    end
    column I18n.t('active_admin.email').capitalize do |user|
      user.email
    end
    column I18n.t('active_admin.state').capitalize do |user|
      user.state
    end
    column I18n.t('active_admin.role').capitalize do |user|
      user.role
    end
  end

  filter :email
  filter :name
  filter :active
  filter :role

  form partial: 'form_user_edit'
end
