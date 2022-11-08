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

  def translate(str)
    row = 8 - str[1].to_i
    column = (('a'..'h').to_a).find_index(str[0])
    return row, column
  end

  def find_piece(pos)
    i,j = pos
    if i < 0 || i > 7 || j < 0 || j > 7
      return ' '
    end
    @arr[i][j]
  end
  
  def add_piece(piece, pos)
    i,j = pos
    @arr[i][j] = piece
  end
end

