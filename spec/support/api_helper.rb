# frozen_string_literal: true

# module ApiHelper
module ApiHelper
  include Rack::Test::Methods
  def app
    Rails.application
  end

  def json_dig(*arr)
    JSON.parse(last_response.body).dig(*arr)
  end
end
