FactoryBot.define do
  factory :item do
    name { Faker::Name.initials }
    content { Faker::Lorem.sentence }
    category_id { '1' }
    status_id { '1' }
    cost_id { '1' }
    area_id { '1' }
    send_day_id { '1' }
    price { '10000' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
