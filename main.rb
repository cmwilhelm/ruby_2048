require 'gosu'
require './gameboard'


class MyWindow < Gosu::Window

  def initialize
    super(640, 480, false)
    self.caption = "HORRIBLE 2048 CLONE"
    @board = GameBoard.new
  end

  def button_up(id)
    return if @board.game_over?
    
    case id
    when Gosu::KbUp
      @board.handle(:up)
    when Gosu::KbRight
      @board.handle(:right)
    when Gosu::KbDown
      @board.handle(:down)
    when Gosu::KbLeft
      @board.handle(:left)
    end
  end

  def draw
    @board.draw
  end
    
end

window = MyWindow.new
window.show
