# bundle exec rspec spec/requests/user_profile_spec.rb
require "rails_helper"

RSpec.describe "User profile restful API", type: :request do
  before do
    @user01 = create(:user)
    post user_session_url,
        params: {
          email: @user01.email,
          password: @user01.password
        }

    @client = response.headers["client"]
    @access_token = response.headers["access-token"]
    @uid = response.headers["uid"]
    @authorization = response.headers["authorization"]
    @expiry = response.headers["expiry"]
  end

  describe "Create user profile" do
    scenario "Sends a post request to create user profile" do
      first_name = "Jane"
      last_name = "Doe"
      billing_address = "123 Address"

      post api_v1_user_profiles_url,
        params: {
          user_profile: {
            first_name: first_name,
            last_name: last_name,
            billing_address: billing_address
          }
        },
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }
      puts "RESPONSE BODY: #{response.body}"

      # check if response is ok/successful
      expect(response).to have_http_status(:ok)

      # check if response body has admin email and role: admin
      expect(json_response["user_profile"]["first_name"]).to eq(first_name)
      expect(json_response["user_profile"]["last_name"]).to eq(last_name)
      expect(json_response["user_profile"]["billing_address"]).to eq(billing_address)
    end
  end

  describe "Display user profile" do
    scenario "Sends a get request to show user profile" do
      first_name = "Jane"
      last_name = "Doe"
      billing_address = "123 Address"

      post api_v1_user_profiles_url,
        params: {
          user_profile: {
            first_name: first_name,
            last_name: last_name,
            billing_address: billing_address
          }
        },
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      puts "RESPONSE BODY: #{response.body}"
      profile = UserProfile.last
      profile_id = profile.id

      get api_v1_user_profile_url(profile_id),
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      # check if response is ok/successful
      expect(response).to have_http_status(:ok)

      # check if response body has admin email and role: admin
      expect(json_response["user_profile"]["id"]).to eq(profile_id)
    end
  end

  describe "Update user profile" do
    scenario "Sends a patch request to update user profile" do
      first_name = "Jane"
      last_name = "Doe"
      billing_address = "123 Address"
      edited_first_name = "Edited Jane"
      edited_last_name = "Edited Doe"
      edited_billing_address = "Edited 123 Address"

      post api_v1_user_profiles_url,
        params: {
          user_profile: {
            first_name: first_name,
            last_name: last_name,
            billing_address: billing_address
          }
        },
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      puts "RESPONSE BODY: #{response.body}"
      profile = UserProfile.last
      profile_id = profile.id

      patch api_v1_user_profile_url(profile_id),
        params: {
          user_profile: {
            first_name: edited_first_name,
            last_name: edited_last_name,
            billing_address: edited_billing_address
          }
        },
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      puts "RESPONSE BODY: #{response.body}"
      expect(response).to have_http_status(:ok)

      expect(json_response["user_profile"]["first_name"]).to eq(edited_first_name)
      expect(json_response["user_profile"]["last_name"]).to eq(edited_last_name)
      expect(json_response["user_profile"]["billing_address"]).to eq(edited_billing_address)
    end
  end

  describe "Delete user profile" do
    scenario "Sends a delete request to delete user profile" do
      first_name = "Jane"
      last_name = "Doe"
      billing_address = "123 Address"

      post api_v1_user_profiles_url,
        params: {
          user_profile: {
            first_name: first_name,
            last_name: last_name,
            billing_address: billing_address
          }
        },
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      profile = UserProfile.last
      profile_id = profile.id

      delete api_v1_user_profile_url(profile_id),
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      puts "RESPONSE BODY: #{response.body}"
      # check if response is ok/successful
      expect(response).to have_http_status(:ok)
      expect(json_response["status"]).to eq("success")
    end
  end

end
