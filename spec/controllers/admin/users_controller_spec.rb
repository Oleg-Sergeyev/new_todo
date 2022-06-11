# frozen_string_literal: true

describe Admin::UsersController, type: :controller do
  before(:each) do
    @user_admin = create(:user_admin)
    @user = build(:user)
    @user_admin_second = build(:user_admin)
    @scope_users = User.includes(:role).where(roles: { code: :default })
    @scope_admins = User.includes(:role).where(roles: { code: :admin })
    sign_in @user_admin
  end

  it 'создает простого пользователя' do
    post :create, params: { user: @user }
    expect { @user.save }.to change { @scope_users.count }.by(1)
  end
  it 'создает второго администратора' do
    post :create, params: { user: @user_admin_second }
    expect { @user_admin_second.save }.to change { @scope_admins.count }.by(1)
  end
end
