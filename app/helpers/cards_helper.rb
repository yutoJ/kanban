module CardsHelper
  def first_column?(card, positions)
    card.column_id == positions.first.column_id
  end

  def last_column?(card, positions)
    card.column_id == positions.last.column_id
  end
end
