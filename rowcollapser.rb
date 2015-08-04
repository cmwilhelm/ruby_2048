require './tile'


# Responsible for taking in sequential lists of
# numerical tiles and attempting to combine them
# according to game rules.

class RowCollapser

  def collapse(originals)
    case originals.length
    when 2
      _handle_two(originals)
    when 3
      _handle_three(originals)
    when 4
      _handle_four(originals)
    else
      _handle_other(originals)
    end
  end

  private

  def _get_new
    Array.new(4)
  end

  def _copy_to_new(new_array, old_array)
    new_array.each_with_index do |elem, index|
      if old_array.length > index
        new_array[index] = old_array[index]
      end
    end
  end

  def _can_combine?(tile_1, tile_2)
    tile_1.value == tile_2.value
  end

  def _combine(tile_1, tile_2)
    Tile.new(tile_1.value + tile_2.value)
  end

  def _handle_two(to_combine)
    new_array = _get_new
    if _can_combine?(to_combine[0], to_combine[1])
      new_array[0] = _combine(to_combine[0], to_combine[1])
    else
      _copy_to_new(new_array, to_combine)
    end
    return new_array
  end

  def _handle_three(to_combine)
    new_array = _get_new

    if _can_combine?(to_combine[0], to_combine[1])
      new_array[0] = _combine(to_combine[0], to_combine[1])
      new_array[1] = to_combine[2]
    elsif _can_combine?(to_combine[1], to_combine[2])
      new_array[0] = to_combine[0]
      new_array[1] = _combine(to_combine[1], to_combine[2])
    else
      _copy_to_new(new_array, to_combine)
    end

    return new_array
  end

  def _handle_four(to_combine)
    new_array = _get_new

    if _can_combine?(to_combine[0], to_combine[1])
      new_array[0] = _combine(to_combine[0], to_combine[1])
      if _can_combine?(to_combine[2], to_combine[3])
        new_array[1] = _combine(to_combine[2], to_combine[3])
      else
        new_array[1] = to_combine[2]
        new_array[2] = to_combine[3]
      end
    elsif _can_combine?(to_combine[1], to_combine[2])
      new_array[0] = to_combine[0]
      new_array[1] = _combine(to_combine[1], to_combine[2])
      new_array[2] = to_combine[3]
    elsif _can_combine?(to_combine[2], to_combine[3])
      new_array[0] = to_combine[0]
      new_array[1] = to_combine[1]
      new_array[2] = _combine(to_combine[2], to_combine[3])
    else
      _copy_to_new(new_array, to_combine)
    end

    return new_array
  end

  def _handle_other(to_combine)
    new_array = _get_new
    _copy_to_new(new_array, to_combine)
    return new_array
  end

end  
