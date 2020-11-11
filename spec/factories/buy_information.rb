FactoryBot.define do
  factory :buy_information do
    token { 'aaa' }
    postnumber { '111-1111' }
    area_id { '1' }
    area_town { Faker::Lorem.sentence }
    area_street { Faker::Lorem.sentence }
    telephonenumber { '00011112222' }
    association :user
    association :item
  end
end
