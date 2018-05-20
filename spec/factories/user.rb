FactoryBot.define do
  factory :user do
    name 'firstuser'
    sequence(:uid) { |n| n }
    provider 'sns'
  end
end
