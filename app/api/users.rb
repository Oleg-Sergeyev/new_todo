# frozen_string_literal: true

require_relative 'helpers/user_filters_helper'

# class Events < Grape::API
class Users < Grape::API
  helpers UserFiltersHelper
  include Grape::Kaminari

  resource :users do
    desc 'Пользователи'
    params do
      use :pagination, per_page: 4, max_per_page: 4, offset: 0
    end
    get '/' do
      present users_scope(params[:role]), with: Entities::User
    end
    resource :state do
      route_param :user_state, type: String do
        before do
          @users = User.where(state: params[:user_state])
        end
        get '/' do
          present @users, with: Entities::User
        end
      end
    end
    resource :id do
      route_param :user_id, type: Integer do
        before do
          @user = User.find(params[:user_id])
        end
        get '/' do
          present @user, with: Entities::User
        end
        post '/' do
          @user.destroy unless @user.admin?
        end
      end
    end
  end
end
