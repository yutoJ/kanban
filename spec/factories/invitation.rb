FactoryBot.define do
  factory :invitation do
    project
    association :invitee, factory: :user
    accept false
    user { project.user }
  end
end
