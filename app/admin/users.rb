# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 1, label: I18n.t('active_admin.label.users').capitalize
  permit_params %i[email name active role_id password password_confirmation state]
  config.sort_order = 'name_asc'
  before_action :user_state, only: :update

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
    column I18n.t('active_admin.email').capitalize, &:email
    column I18n.t('active_admin.state').capitalize, &:state
    column I18n.t('active_admin.role').capitalize, &:role
  end

  filter :email
  filter :name
  filter :active
  filter :role

  form partial: 'form_user_edit'

  controller do
    def user_state
      case params[:user][:state]
      when 'active'
        return if resource.may_on?
      when 'banned'
        return if resource.may_off? || resource.may_restore?
      when 'archived'
        return if resource.may_remove?
      end
      redirect(resource.id)
    end

    def redirect(id)
      redirect_to edit_admin_user_path(id),
                  flash: { error: t('active_admin.messages.state_change_error').capitalize }
    end
  end
end
