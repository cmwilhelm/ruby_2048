require './rowcollapser'
require './tile'


# Processes move requests against 4x4 2-d arrays.
# Public methods correspond to the four keyboard
# directions and return new 2-d arrays.

class MoveHandler

  @@collapser = RowCollapser.new
  
  def up(original)
    swapped = _swap_cols_for_rows(original)
    handled = swapped.map do |row|
      tiles = _get_tiles(row)
      @@collapser.collapse(tiles)
    end
     _swap_cols_for_rows(handled)
  end

  def right(original)
    original.map do |row|
      tiles = _get_tiles(row.reverse)
      @@collapser.collapse(tiles).reverse
    end
  end

  def down(original)
    swapped = _swap_cols_for_rows(original)
    handled = swapped.map do |row|
      tiles = _get_tiles(row.reverse)
      @@collapser.collapse(tiles).reverse
    end
    _swap_cols_for_rows(handled)
  end

  def left(original)
    original.map do |row|
      tiles = _get_tiles(row)
      @@collapser.collapse(tiles)
    end
  end

  def _swap_cols_for_rows(grid)
    (0..3).map do |row_index|
      (0..3).map do |col_index|
        grid[col_index][row_index]
      end
    end
  end

  def _get_tiles(row)
    row.select { |elem| elem.kind_of?(Tile) }
  end
    
  private :_get_tiles, :_swap_cols_for_rows
      
end
