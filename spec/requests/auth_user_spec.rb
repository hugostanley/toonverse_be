# bundle exec rspec spec/requests/auth_user_spec.rb
require "rails_helper"

RSpec.describe "Authenticate user", type: :request do
  before do
    @user01 = create(:user)
  end

  describe "Register user" do
    scenario "Sends a post request to register user" do
      user = {
        email: "user@email.com",
        password: "password"
      }
      post user_registration_url,
        params: {
          email: user[:email],
          password: user[:password],
          password_confirmation: user[:password]
        }
      puts "RESPONSE BODY: #{response.body}"

      # check if response is ok/successful
      expect(response).to have_http_status(:ok)

      # check if response body has admin email and role: admin
      expect(json_response["data"]["uid"]).to eq(user[:email])
      expect(json_response["data"]["email"]).to eq(user[:email])
    end
  end

  describe "Login user" do
    scenario "Sends a post request to login user" do
      post user_session_url,
        params: {
          email: @user01.email,
          password: @user01.password
        }

      puts "RESPONSE BODY: #{response.body}"

      expect(response).to have_http_status(:ok)

      expect(json_response["data"]["uid"]).to eq(@user01.email)
      expect(json_response["data"]["email"]).to eq(@user01.email)
    end
  end

  describe "Logout user" do
    scenario "Sends a delete request to logout user" do
      post user_session_url,
        params: {
          email: @user01.email,
          password: @user01.password
        }
      puts "RESPONSE HEADER: #{response.headers}"
      puts "RESPONSE BODY: #{response.body}"

      client = response.headers["client"]
      access_token = response.headers["access-token"]
      uid = response.headers["uid"]

      delete destroy_user_session_url,
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
