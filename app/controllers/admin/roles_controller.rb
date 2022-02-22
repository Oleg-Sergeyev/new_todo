# frozen_string_literal: true

module Admin
  class RolesController < Admin::ApplicationController
    before_action :set_admin_role, only: %i[show edit update destroy]

    # GET /admin/roles or /admin/roles.json
    def index
      authorize [:admin, Role]
      # @admin_roles = policy_scope(User, policy_scope_class: Admin::RolePolicy::Scope)
      # @admin_roles = Admin::Role.all
      @admin_roles = policy_scope(Role.all, policy_scope_class: Admin::RolePolicy::Scope)
    end

    # GET /admin/roles/1 or /admin/roles/1.json
    def show
      authorize [:admin, Role]
    end

    # GET /admin/roles/new
    def new
      @admin_role = Role.new
      authorize [:admin, @admin_role]
    end

    # GET /admin/roles/1/edit
    def edit
      authorize [:admin, Role]
    end

    # POST /admin/roles or /admin/roles.json
    def create
      @admin_role = Role.new(admin_role_params)
      authorize [:admin, @admin_role]

      respond_to do |format|
        if @admin_role.save
          format.html { redirect_to admin_role_url(@admin_role), notice: 'Role was successfully created.' }
          format.json { render :show, status: :created, location: @admin_role }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin_role.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/roles/1 or /admin/roles/1.json
    def update
      authorize [:admin, @admin_role]
      respond_to do |format|
        if @admin_role.update(admin_role_params)
          format.html { redirect_to admin_role_url(@admin_role), notice: 'Role was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_role }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @admin_role.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/roles/1 or /admin/roles/1.json
    def destroy
      @admin_role.destroy
      authorize [:admin, @admin_role]

      respond_to do |format|
        format.html { redirect_to admin_roles_url, notice: 'Role was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_role
      @admin_role = Role.find(params[:id])
      authorize [:admin, @admin_role]
    end

    # Only allow a list of trusted parameters through.
    def admin_role_params
      params.require(:role).permit(:id, :name, :code)
    end
  end
end
