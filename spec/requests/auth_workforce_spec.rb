# bundle exec rspec spec/requests/auth_workforce_spec.rb

require "rails_helper"

RSpec.describe "Authenticate workforce", type: :request do
  before do
    @admin = create(:workforce, :admin)
  end

  scenario "Sends a post request to login admin" do
    post "http://localhost:3000/w_auth/sign_in",
    params: { email: @admin.email, password: @admin.password }
    puts response.body

    # check if response is ok/successful
    expect(response).to have_http_status(:ok)

    # check if response body has admin email and role: admin
    expect(json_response["data"]["uid"]).to eq(@admin.email)
    expect(json_response["data"]["email"]).to eq(@admin.email)
    expect(json_response["data"]["role"]).to eq("admin")
  end
end
