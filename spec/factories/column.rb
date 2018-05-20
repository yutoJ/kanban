FactoryBot.define do
  factory :column do
    project
    name 'TO'
    user { project.user }
  end
end
