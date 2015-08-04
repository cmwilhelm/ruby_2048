require 'gosu'
require './gameboard'


class GameWindow < Gosu::Window

  def initialize
    super(640, 480, false)
    self.caption = "HORRIBLE 2048 CLONE"
    @board = GameBoard.new
  end

  def button_up(id)
    return if @board.game_over?

    case id
    when Gosu::KbUp
      @board.handle_input(:up)
    when Gosu::KbRight
      @board.handle_input(:right)
    when Gosu::KbDown
      @board.handle_input(:down)
    when Gosu::KbLeft
      @board.handle_input(:left)
    end
  end

  def draw
    @board.draw
  end

end
