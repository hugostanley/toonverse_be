FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@email.com" }
    password { "111111" }
    password_confirmation { "111111" }
    sequence(:id) { |n| n+1 }

  end
end
