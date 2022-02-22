# frozen_string_literal: true

module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_admin_user, only: %i[show edit update destroy toggle generate]
    # after_action :verify_authorized, except: :index
    # after_action :verify_policy_scoped, only: :index
    add_breadcrumb 'users', :admin_users_path

    # GET /admin/users or /admin/users.json
    def index
      authorize [:admin, User]
      # admin_users = policy_scope(User, policy_scope_class: Admin::UserPolicy::Scope)
      # sql = '(SELECT code FROM roles WHERE id = users.role_id) as code, id, name, email, active, role_id, created_at'
      # Rails.logger.info "++++#{User.select(code: Role.where(id: :user_id).pluck(:code).first).all}+++"
      # @admin_users = admin_users.select(sql).page(params[:page]).per(5)
      # @admin_users = admin_users.includes(:role).pluck(:name, :email, :active, :code)
      # .page(params[:page])
      # .per(5)
      # @admin_users = policy_scope(User.includes(:role), policy_scope_class: Admin::UserPolicy::Scope)
      @admin_users = policy_scope(User.includes(:role), policy_scope_class: Admin::UserPolicy::Scope)
                     .page(params[:page])
                     .per(5)
      # @admin_users = policy_scope(User.includes(:role), policy_scope_class: Admin::UserPolicy::Scope)
      # .page(params[:page])
      # .per(5)#.as_json(only: [:id, :name, :email, :active, :code, :created_at])
      # Rails.logger.info "!!!!!!!!!!#{@admin_users.first.role.code}!!!!!!!!!!!!"
      # @admin_users = User.all.joins(:role).select("roles.code as code").group("users.id")
    end

    def toggle
      authorize [:admin, @admin_user]
      @admin_user.update_column(:active, !@admin_user.active)
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    def generate_user
      render json: { new_user: { name: new_user.name } }
    end

    # GET /admin/users/1 or /admin/users/1.json
    def show
      authorize [:admin, User]
      add_breadcrumb @admin_user.name, admin_user_path(@admin_user.id)
    end

    # GET /admin/users/new
    def new
      @admin_user = User.new
      authorize [:admin, @admin_user]
      generate_user if params[:generate] == 'true'
      add_breadcrumb 'new', admin_users_path
    end

    # GET /admin/users/1/edit
    def edit
      authorize [:admin, User]
      add_breadcrumb @admin_user.name, admin_user_path(@admin_user.id)
      add_breadcrumb 'edit'
    end

    # POST /admin/users or /admin/users.json
    def create
      @admin_user = User.new(admin_user_params)
      authorize [:admin, @admin_user]
      respond_to do |format|
        if @admin_user.save
          format.html { redirect_to [:admin, @admin_user], notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: [:admin, @admin_user] }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin_user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/users/1 or /admin/users/1.json
    def update
      authorize [:admin, @admin_user]
      # user_update if params[:edit] == 'true'
      # Rails.logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{admin_user_params}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      respond_to do |format|
        if @admin_user.update(admin_user_params)
          format.html { redirect_to [:admin, @admin_user], notice: 'User was successfully updated.' }
          format.json { render :edit, status: :ok, location: [:admin, @admin_user] }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @admin_user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/users/1 or /admin/users/1.json
    def destroy
      if current_user.admin? && @admin_user.admin?
        @admin_user.errors.add(:name, message: 'Impossible to delete!')
        render :show
        return nil
      end
      @admin_user.destroy
      authorize [:admin, @admin_user]
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def new_user
      email = FFaker::Internet.safe_email
      default_role = Role.new(name: 'Пользователь', code: :default)
      hash_user = {
        name: email,
        email: email,
        password: email,
        role: default_role,
        active: [true, false].sample,
        events_unffd_count: 0,
        events_ffd_count: 0,
        items_unffd_count: 0,
        items_ffd_count: 0
      }
      User.new(hash_user)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = User.find(params[:id])
      authorize [:admin, @admin_user]
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.require(:user).permit(:id, :role_id, :name, :email, :password_confirmation, :password, :current_passwor,
                                   :active)
    end
  end
end
