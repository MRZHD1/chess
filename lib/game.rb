class Game
  def initialize
    @arr = []
    @color = 'white'
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
    p piece.moves()
    p [x,y]
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
