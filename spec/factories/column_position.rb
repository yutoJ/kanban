FactoryBot.define do
  factory :column_position do
    column
    sequence(:sequence_num) { |n| n }
  end
end
