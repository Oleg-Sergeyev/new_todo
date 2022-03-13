# frozen_string_literal: true

# class UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    # @users = policy_scope(User)#.page(params[:page]).per(5)
    users = policy_scope(User, policy_scope_class: Admin::UserPolicy::Scope)
    sql = '(SELECT code FROM roles WHERE id = users.role_id) as code, id, name, email, active, role_id, created_at'
    @users = users.select(sql).page(params[:page]).per(20)
  end

  def show
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if current_user == @user && current_user.role_id != user_params[:role_id]
      @user.errors.add(:name, message: 'Impossible to update!')
      render :show
      return nil
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @user
    if current_user.admin? && @user.admin?
      @user.errors.add(:name, message: 'Impossible to delete!')
      render :show
      return nil
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :role_id, :name, :email, :password_confirmation, :password, :current_passwor,
                                 :active)
  end
end
