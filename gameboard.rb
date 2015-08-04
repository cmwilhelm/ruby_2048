require 'gosu'
require './movehandler'
require './tile'


# Holds the current game state and updates it
# based on incoming commands.

class GameBoard

  @@font = Gosu::Font.new(20)
  @@move_handler = MoveHandler.new

  def initialize
    @out_of_moves = false
    @grid = Array.new(4) { Array.new(4) }
    _add_random
  end

  def any_unoccupied?
    @grid.each do |row|
      return true if row.find { |elem| !elem.nil? }
    end
    return false
  end

  def _all_unoccupied
    unoccupied = []
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |elem, col_index|
        unoccupied << [row_index, col_index] if elem.nil?
      end
    end
    return unoccupied
  end

  def _add_random
    row, col = _all_unoccupied.sample
    @grid[row][col] = Tile.new([2, 4].sample)
  end

  def _grids_equal(grid_1, grid_2)
    grid_1.each_with_index do |row, row_index|
      row.each_with_index do |elem, col_index|
        return false if elem != grid_2[row_index][col_index]
      end
    end
    return true
  end

  def _can_move?
    futures = [
      @@move_handler.up(@grid),
      @@move_handler.right(@grid),
      @@move_handler.down(@grid),
      @@move_handler.left(@grid)
    ]

    futures.any? { |future| !_grids_equal(@grid, future) }
  end

  def game_over?
    @out_of_moves
  end
  
  def handle(direction)
    old_grid = @grid
    @grid = @@move_handler.send(direction, @grid)

    if _can_move?
      _add_random unless _grids_equal(@grid, old_grid)
    else
      @out_of_moves = true
    end
  end

  def draw
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |elem, col_index|
        _draw_elem(elem, row_index, col_index)
      end
    end
  end

  def _draw_elem(elem, row_index, col_index)
    text   = elem.nil? ? '[ ]' : elem.value
    mod    = 100
    offset = 50
    x_pos  = offset + mod * col_index
    y_pos  = offset + mod * row_index
    @@font.draw(text, x_pos, y_pos, 3, 1.0, 1.0, 0xff_ffff00)
  end

  private :_all_unoccupied, :_add_random, :_draw_elem, :_grids_equal
  
end
