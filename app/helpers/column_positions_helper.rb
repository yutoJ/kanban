module ColumnPositionsHelper
  def current_position(column_id, positions)
    positions.map.with_index do |position, i|
      return positions[i] if position.column_id == column_id
    end
  end

  def left_position(column_id, positions)
    positions.map.with_index do |position, i|
      return positions[i - 1] if position.column_id == column_id
    end
  end

  def right_position(column_id, positions)
    positions.map.with_index do |position, i|
      return positions[i + 1] if position.column_id == column_id
    end
  end
end
