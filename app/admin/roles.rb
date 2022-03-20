# ActiveAdmin.register Role

ActiveAdmin.register Role do
  menu priority: 5, label: 'Роли'
  actions :index, :show, :new, :create, :update, :edit
  permit_params %i[id name code]

  controller do
    # overrides InheritedResources::BaseHelpers#destroy_resource
    # def destroy_resource(object)
    #   object.soft_delete
    # end
  end
 
 
  index do
    column :name do |role|
      link_to(role.name, edit_admin_role_path(role.id), class: 'link-dark', style: 'font-weight: bolder;')
    end
    actions
  end

  form partial: 'form_role_edit'

  # Filters
  filter :id
  filter :name, as: :select, collection: -> { Role.pluck(:name) }
  filter :code, as: :select, collection: -> { Role.pluck(:code) }
end
