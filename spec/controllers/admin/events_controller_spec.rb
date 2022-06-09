
describe Admin::EventsController, type: :controller do

  before(:each) do
    @user = FactoryBot.create(:user)
    @user_admin = FactoryBot.create(:user_admin)
    @event = FactoryBot.create(:event)
    sign_in @user_admin
  end

  it 'создает задание' do
    post :create, params: { user: @user, event: @event }
    expect(Event.all.count).to eq(1)
  end
end
