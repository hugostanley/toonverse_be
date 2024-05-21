# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = Workforce.where(email: "admin@email.com").first_or_initialize
admin.update!(
  email: "admin@email.com",
  password: "111111",
  password_confirmation: "111111",
  role: "admin",
  confirmed_at: Time.current
)

3.times do |index|
  Workforce.create(
    email: "artist#{index + 1}@email.com",
    password: "111111",
    password_confirmation: "111111",
  )
end

3.times do |index|
  User.create(
    email: "user#{index + 1}@email.com",
    password: "111111",
    password_confirmation: "111111",
  )
end
