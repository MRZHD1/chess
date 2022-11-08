require './lib/colors.rb'
class Piece
  def initialize(position, color, game)
    @row, @column = position
    @color = color
    @@game = game
  end
  
  def update(position)
    @row, @column = position
  end
end

class Pawn < Piece
  def to_s
    if @color == 'black'
      return '♟'.blue
    else
      return '♟'.red
    end
  end

  def moves
    valid = []
    if @color == 'black' 
      # Standard move
      if @row < 8
        valid += [[@row + 1, @column]]
      end
      # Starting row 2 blocks forward
      if @row == 1
        valid += [[@row + 2, @column]]
      end
      # En Passant
      if @@game.find_piece([@row + 1, @column + 1]) != ' '
        valid += [[@row + 1, @column + 1]]
      end
    else # If it's white
      # Standard move
      if @row > 0
        valid += [[@row - 1, @column]]
      end
      # Starting row 2 blocks forward
      if @row == 6
        valid += [[@row - 2, @column]]
      end
      # En Passant
      if @@game.find_piece([@row - 1, @column - 1]) != ' '
        valid += [[@row - 1, @column - 1]]
      end
    end
    return valid
  end
end

