FactoryBot.define do
  factory :card do
    column
    project { column.project }
    due_date Date.new(2018, 5, 20)
    sequence(:name) { |n| "ISSUE#{n}" }
    association :assignee, factory: :user
    user { project.user }
  end
end
