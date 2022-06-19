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
  it 'returns success if request format is CSV' do
    get :index, format: :csv
    expect(response).to have_http_status(:success)
    expect(response.header['Content-Type']).to include 'text/csv'
  end
  it 'returns success if request format is xml' do
    get :index, format: :xml
    expect(response).to have_http_status(:success)
    expect(response.header['Content-Type']).to include 'application/xml'
  end
  it 'returns success if request format is JSON' do
    get :index, format: :json
    expect(response).to have_http_status(:success)
    expect(response.header['Content-Type']).to include 'application/json'
  end
end
