FactoryBot.define do
  factory :item do
    name                     { Faker::Lorem.sentence }
    description              { Faker::Lorem.sentence }
    price                    { Faker::Number.within(range: 300..9_999_999) }
    category_id              { Faker::Number.within(range: 2..11) }
    sales_status_id          { Faker::Number.within(range: 2..7) }
    shipping_free_status_id  { Faker::Number.within(range: 2..3) }
    prefecture_id            { Faker::Number.within(range: 2..48) }
    scheduled_delivery_id    { Faker::Number.within(range: 2..4) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
