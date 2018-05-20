FactoryBot.define do
  factory :card do
    column
    project { column.project }
    due_date Date.new(2018, 5, 20)
    name 'TO'
    user { project.user }
  end
end
