# bundle exec rspec spec/requests/auth_admin_spec.rb
require "rails_helper"

RSpec.describe "Authenticate admin", type: :request do
  before do
    @admin = create(:workforce, :admin)
  end

  describe "Login admin" do
    scenario "Sends a post request to login admin" do
      post "http://localhost:3000/w_auth/sign_in",
        params: { email: @admin.email, password: @admin.password }
      puts "RESPONSE BODY: #{response.body}"

      # check if response is ok/successful
      expect(response).to have_http_status(:ok)

      # check if response body has admin email and role: admin
      expect(json_response["data"]["uid"]).to eq(@admin.email)
      expect(json_response["data"]["email"]).to eq(@admin.email)
      expect(json_response["data"]["role"]).to eq("admin")
    end
  end

  describe "Logout admin" do
    scenario "Sends a delete request to logout admin" do
      post "http://localhost:3000/w_auth/sign_in",
        params: { email: @admin.email, password: @admin.password }
      puts "RESPONSE HEADER: #{response.headers}"
      puts "RESPONSE BODY: #{response.body}"

      client = response.headers["client"]
      access_token = response.headers["access-token"]
      uid = response.headers["uid"]

      delete "http://localhost:3000/w_auth/sign_out",
      # required headers:
        headers: {
          "uid" => uid,
          "client" => client,
          "access-token" => access_token
        }

      expect(response).to have_http_status(:ok)
      expect(json_response["success"]).to eq(true)
    end
  end
end
