FactoryBot.define do
    factory :movie do
      user
      video_url { Faker::Internet.url }
    end
end