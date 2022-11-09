class Game
  def initialize
    @arr = []
    @color = 'white'
    @rgb = @color == 'white' ? "0;0;153" : "204;0;0"
    8.times {@arr += [Array.new(8, ' ')]}
  end

  def build_board
    board = ''
    color = 0
    n = 0
    board += "   0  1  2  3  4  5  6  7 "
    for line in @arr
      board += "\n"
      board += "#{n} "
      color = color == 0 ? 1 : 0 
      for piece in line
        board += " #{piece}".bg(color) + " ".bg(color)
        color = color == 0 ? 1 : 0 
      end
      board += " #{n}"
      n += 1
    end
    board += "\n   0  1  2  3  4  5  6  7 "
    puts board
  end

  def translate(str)
    row = 8 - str[1].to_i
    column = (('a'..'h').to_a).find_index(str[0])
    return column == nil ? nil : row, column
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

  def move(from, to)
    i,j = translate(from)
    x,y = translate(to)

    if i == nil || j == nil || x == nil || y == nil
      puts 'Not a valid position'
      return
    end

    piece = find_piece([i,j])

    if piece == ' '
      puts 'Not a valid piece'
      return
    end

    if piece.color != @color
      puts 'Wrong colored piece!'
      return
    end
    # p piece.moves()
    if piece.moves().include?([x,y])    
      @arr[x][y] = piece
      @arr[i][j] = ' '
      piece.update([x,y])
    else
      puts 'Invalid move!'
      return
    end
    @color = @color == 'white' ? 'black' : 'white'
  end
end
