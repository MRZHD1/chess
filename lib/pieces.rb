require './lib/colors.rb'
class Piece
  attr_accessor :color
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
      if @row < 8 && @@game.find_piece([@row + 1, @column]) == ' '
        valid += [[@row + 1, @column]]

        # Starting row 2 blocks forward
        if @row == 1 && @@game.find_piece([@row + 2, @column]) == ' '
          valid += [[@row + 2, @column]]
        end
      end
      # En Passant
      if @@game.find_piece([@row + 1, @column + 1]) != ' '
        valid += [[@row + 1, @column + 1]]
      end
    else # If it's white
      # Standard move
      if @row > 0 && @@game.find_piece([@row - 1, @column]) == ' '
        valid += [[@row - 1, @column]]

        # Starting row 2 blocks forward
        if @row == 6 && @@game.find_piece([@row - 2, @column]) == ' '
          valid += [[@row - 2, @column]]
        end
      end
      # En Passant
      if @@game.find_piece([@row - 1, @column - 1]) != ' '
        valid += [[@row - 1, @column - 1]]
      end
    end
    return valid
  end
end

class Rook < Piece
  def to_s
    if @color == 'black'
      return '♜'.blue
    else
      return '♜'.red
    end
  end

  def moves
    valid = []

    # Vertical
    i = 1
    until @row + i > 7 || @@game.find_piece([@row + i, @column]) != ' '
      valid += [[@row + i, @column]]
      i += 1
    end
    i = 1
    until @row - i < -0 || @@game.find_piece([@row - i, @column]) != ' '
      valid += [[@row - i, @column]]
      i += 1
    end

    #Horizontal
    i = 1
    until @column + i > 7 || @@game.find_piece([@row, @column + i]) != ' '
      valid += [[@row, @column + i]]
      i += 1
    end
    i = 1
    until @column - i < 0 || @@game.find_piece([@row, @column - i]) != ' '
      valid += [[@row, @column - i]]
      i += 1
    end
    return valid
  end
end