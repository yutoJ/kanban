class Column < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 }

  has_one :column_position, dependent: :destroy

  def save_with_column_position
    ColumnPosition.add_seq_record_to(self)
    save
  end
end
