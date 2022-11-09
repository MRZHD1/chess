require './lib/colors.rb'
class Piece
  attr_accessor :color
  def initialize(position, color, game)
    @row, @column = position
    @color = color
    @rgb = @color == 'black' ? "0;0;153" : "204;0;0"
    @enemy = false
    @@game = game
  end
  
  def update(position)
    @row, @column = position
  end

  def blocked(x,y)
    if @row+x < 0 || @row+x > 7 || @column+y < 0 || @column+y > 7 || @enemy == true
      @enemy = false
      return true
    elsif @@game.find_piece([@row + x, @column + y]).to_s.include?(@rgb)
      return true
    elsif @@game.find_piece([@row + x, @column + y]) != ' '
      @enemy = true
      return false
    else
      return false
    end
  end
end

class Pawn < Piece
  def to_s
    @color == 'black' ? '♟'.blue : '♟'.red
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
      # Diagonal
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
      # Diagonal
      if @@game.find_piece([@row - 1, @column - 1]) != ' '
        valid += [[@row - 1, @column - 1]]
      end
    end
    return valid
  end
end

class Rook < Piece
  def to_s
    @color == 'black' ? '♜'.blue : '♜'.red
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

class Bishop < Piece
  def to_s
    @color == 'black' ? '♝'.blue : '♝'.red
  end

  def moves
    valid = []

    i = 1
    until self.blocked(i,i)
      valid += [[@row + i, @column + i]]
      i += 1
    end

    i = 1
    until self.blocked(i,-i)
      valid += [[@row + i, @column - i]]
      i += 1
    end

    i = 1
    until self.blocked(-i,-i)
      valid += [[@row - i, @column - i]]
      i += 1
    end

    i = 1
    until self.blocked(-i,i)
      valid += [[@row - i, @column + i]]
      i += 1
    end
    return valid
  end
end