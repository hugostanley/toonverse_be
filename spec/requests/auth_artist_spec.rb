# bundle exec rspec spec/requests/auth_artist_spec.rb
require "rails_helper"

RSpec.describe "Authenticate artist", type: :request do
  before do
    @admin = create(:workforce, :admin)
    post "http://localhost:3000/w_auth/sign_in",
      params: { email: @admin.email, password: @admin.password }

    @client = response.headers["client"]
    @access_token = response.headers["access-token"]
    @uid = response.headers["uid"]
    @authorization = response.headers["authorization"]
    @expiry = response.headers["expiry"]
  end

  describe "Invite artist" do
    scenario "Sends an invitation email to the artist" do
      artist_email = "artist01@email.com"
      artist = create(:workforce, email: artist_email)
      artist.invite!

      post workforce_invitation_url, # "http://localhost:3000/w_auth/invitation"
        params: { email: artist_email },
        headers: {
          "uid" => @uid,
          "client" => @client,
          "access-token" => @access_token,
          "expiry" => @expiry,
          "authorization" => @authorization
        }

      puts "RESPONSE BODY: #{response.body}"
      ActionMailer::Base.deliveries.each do |email|
        puts "------------start of mail-------------"
        puts "Subject: #{email.subject}"
        puts "To: #{email.to}"
        puts "From: #{email.from}"
        puts "Body: #{email.body}"
        puts "-------------end of mail--------------"
      end

      expect(response).to have_http_status(:created)

      expect(json_response["success"][0]).to eq("Workforce invited.")
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.last.to).to include(artist_email)
    end
  end

  # describe "Accepting an Invitation" do
  #   scenario "Artist accepts the invitation and sets password" do
  #     artist_email = "artist01@email.com"
  #     artist = create(:workforce, email: artist_email)
  #     artist.invite!

  #     post workforce_invitation_url,
  #       params: { email: artist_email },
  #       headers: {
  #         "uid" => @uid,
  #         "client" => @client,
  #         "access-token" => @access_token,
  #         "expiry" => @expiry,
  #         "authorization" => @authorization
  #       }

  #     ActionMailer::Base.deliveries.each do |email|
  #       puts "------------start of mail-------------"
  #       puts "Subject: #{email.subject}"
  #       puts "To: #{email.to}"
  #       puts "From: #{email.from}"
  #       puts "Body: #{email.body}"
  #       puts "-------------end of mail--------------"
  #     end

  #     artist = Workforce.last
  #     # puts "Artist attributes: #{artist.attributes.inspect}"
  #     invitation_token = artist.invitation_token

  #     put workforce_invitation_url,
  #       params: {
  #         workforce: {
  #           password: "new_password",
  #           password_confirmation: "new_password",
  #           invitation_token: invitation_token
  #         }
  #       }

  #   puts "RESPONSE BODY: #{response.body}"

  #   expect(response).to have_http_status(:found)
  #   end
  # end

end
