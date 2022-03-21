# frozen_string_literal: true

ActiveAdmin.register User do
  #before_action :left_sidebar!#, only: [:show]
  menu priority: 2, label: 'Пользователи сайта'
  permit_params %i[email name active role_id password password_confirmation]
  config.sort_order = 'name_asc'

  # sidebar :help, priority: 0 do
  #   ul do
  #     li "Basic"
  #     li "Sequrity"
  #   end
  # end

  index do
    # selectable_column
    #column :id, &:id
    column(:avatar, width: 100) do |user|
      if user.avatar.attached?
        image_tag user.avatar.variant(resize: '30x30'), class: 'img-fluid rounded-circle'
      else
        tag.i(class: 'fa fa-user-circle-o', style: 'font-size:28px; color: rgb(63 67 70)')
      end
    end
    column :name do |user|
      link_to(user.name, edit_admin_user_path(user.id), class: 'link-dark', style: 'font-weight: bolder;')
      #link_to(user.name, admin_user_basic_path(user.id), class: 'link-dark', style: 'font-weight: bolder;')
    end
    column :email
    column :active
    column :role
    # column :created_at
    #actions
  end

  filter :email
  filter :name
  filter :active
  filter :role

  controller do
    # def edit
    #   #render 'admin/users/form_edit', layout: 'active_admin'
    #   render partial: 'admin/users/form_edit'
    # end

    # def new
    #   #render 'admin/users/form_new', layout: 'active_admin'
    #   redirect_to admin_create_user_path
    #   render 'admin/users/form_new', layout: 'active_admin'
    # end
  end

  form partial: 'form_user_edit'
end
