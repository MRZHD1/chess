require_relative 'colors.rb'

class Game
  def initialize
    @arr = []
    8.times {@arr += [Array.new(8, ' ')]}
  end

  def build_board
    board = ''
    color = 0
    for line in @arr
      board += "\n"
      color = color == 0 ? 1 : 0 
      for piece in line
        board += " #{piece}".bg(color) + " ".bg(color)
        color = color == 0 ? 1 : 0 
      end
    end
    puts board
  end
end

game = Game.new()
game.build_board