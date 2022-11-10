class Game
  def initialize
    @arr = []
    @kings = [[],[]]
    @color = 'white'
    @rgb = @color == 'white' ? "0;0;153" : "204;0;0"
    8.times {@arr += [Array.new(8, ' ')]}
  end
  
  def standard_position
    8.times do |i|
      # Adding Pawns
      self.new_piece(Pawn, 'white', [6,i])
      self.new_piece(Pawn, 'black', [1,i])
      # Adding Rooks
      if i == 0 || i == 7
        self.new_piece(Rook, 'white', [7, i])
        self.new_piece(Rook, 'black', [0, i])
      end
      # Adding Bishops
      if i == 1 || i == 6
        self.new_piece(Bishop, 'white', [7, i])
        self.new_piece(Bishop, 'black', [0, i])
      end
      # Adding Knights
      if i == 2 || i == 5
        self.new_piece(Knight, 'white', [7, i])
        self.new_piece(Knight, 'black', [0, i])
      end
      # Adding Queens
      if i == 3
        self.new_piece(Queen, 'white', [7, i])
        self.new_piece(Queen, 'black', [0, i])
      end
      # Adding Kings
      if i == 4
        self.new_piece(King, 'black', [0, i])
        self.new_piece(King, 'white', [7,i])
      end
    end
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

  def new_piece(piece, color, pos)
    i,j = pos
    @arr[i][j] = piece.new(pos, color, self)
    if @arr[i][j].is_a?(King)
      if color == 'white'
        @kings[0] = @arr[i][j]
      else
        @kings[1] = @arr[i][j]
      end
    end
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

  def pieces
    pieces = []
    for row in @arr
      for piece in row
        if piece != ' '
          pieces += [piece]
        end
      end
    end
    return pieces
  end

  def check
    king = @color == 'white' ? @kings[0] : @kings[1]
    for piece in self.pieces
      if piece.color != @color && piece.moves.include?([king.row, king.column])
        return true
      end
    end
    return false
  end
end
