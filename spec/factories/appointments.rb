FactoryBot.define do
  factory :appointment do
    city { 'city' }
    date { Time.now }
    user
    billionaire
  end
end
