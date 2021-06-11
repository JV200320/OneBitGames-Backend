FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    os { Faker::Computer.os }
    storage { "500GB" }
    processor { "AMD Ryzen 7" }
    memory { "8GB" }
    video_board { "GTX 1050" }
  end
end
