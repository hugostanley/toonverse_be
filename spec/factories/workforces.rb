FactoryBot.define do
  factory :workforce do
    sequence(:email) { |n| "artist_#{n}@email.com" }
    password { "111111" }
    password_confirmation { "111111" }
    sequence(:id) { |n| n+1 }
    role { "artist" } # default role

    trait :admin do
      email { "admin@email.com" }
      role { "admin" }
    end

  end
end
