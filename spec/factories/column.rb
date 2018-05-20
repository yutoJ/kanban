FactoryBot.define do
  factory :column do
    project
    sequence(:name) { |n| "STAGE#{n}" }
    user { project.user }
  end
end
