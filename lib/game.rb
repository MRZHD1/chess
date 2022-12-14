class Game
  attr_accessor :arr
  attr_accessor :color
  attr_accessor :kings
  attr_accessor :passant
  attr_accessor :half_clock
  attr_accessor :full_clock
  def initialize
    @half_clock = 0
    @full_clock = 1
    @arr = []
    @kings = [[],[]]
    @color = 'white'
    @rgb = @color == 'white' ? "0;0;153" : "204;0;0"
    @passant = '-'
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
      if i == 2 || i == 5
        self.new_piece(Bishop, 'white', [7, i])
        self.new_piece(Bishop, 'black', [0, i])
      end
      # Adding Knights
      if i == 1 || i == 6
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
    board += "Type in the square you want to move from, then the square you want to move to\n"
    board += "Example: 'e2e4'. You can also type in 'save' to save your game. \n"
    board += "   a  b  c  d  e  f  g  h "
    for line in @arr
      board += "\n"
      board += "#{8-n} "
      color = color == 0 ? 1 : 0 
      for piece in line
        board += " #{piece}".bg(color) + " ".bg(color)
        color = color == 0 ? 1 : 0 
      end
      board += " #{8-n}"
      n += 1
    end
    board += "\n   a  b  c  d  e  f  g  h "
    puts board
  end

  def translate(str)
    row = 8 - str[1].to_i
    column = (('a'..'h').to_a).find_index(str[0])
    return column == nil ? nil : row, column
  end

  def detranslate(x,y)
    letter = (('a'..'h').to_a)[y]
    number = (8-x).to_s
    return "#{letter}#{number}"
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
    return @arr[i][j]
  end


  def move(from, to)
    @passant = '-'

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

    if piece.is_a?(King) && !(self.check?) && (j-y).abs == 2 && self.castle(piece, y)
      return
    end

    before = @arr[x][y]
    if piece.moves.include?([x,y])
      if self.test_check?(piece,x,y,i,j)
        puts 'This move would put you into check!'
        return
      else
        if @arr[x][y] == ' ' && !(piece.is_a?(Pawn))
          @half_clock += 1
        else
          @half_clock = 0
        end
        @arr[x][y] = piece
        @arr[i][j] = ' '
        piece.update([x,y])
      end
    else
      puts 'Invalid move!'
      return
    end

    if @color == 'black'
      @full_clock += 1
      @color = 'white'
    else
      @color = 'black'
    end
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

  def check?
    king = @color == 'white' ? @kings[0] : @kings[1]
    if king == []
      return false
    end
    for piece in self.pieces
      if piece.color != @color && piece.moves().include?([king.row, king.column])
        return true
      end
    end
    return false
  end

  def test_check?(piece,x,y,i,j)
    # i,j : from
    # x,y : to
    before_piece = @arr[x][y]
    @arr[x][y] = piece
    @arr[i][j] = ' '
    piece.update([x,y])
    value = self.check?.to_s
    
    @arr[x][y] = before_piece
    @arr[i][j] = piece
    piece.update([i,j])
    return value == 'true'
  end

  def check_mate?
    unless self.check?
      return false
    end
    for piece in self.pieces
      if piece.color == @color
        for move in piece.moves
          i,j = piece.row, piece.column
          x,y = move
          unless self.test_check?(piece,x,y,i,j)
            return false
          end
        end
      end
    end
    return true
  end

  def castle(king, y, check=false)
    if king.column - y > 0 # Long Castle
      conditions = [
        king.castle == true,
        self.find_piece([king.row, king.column - 1]) == ' ',
        self.find_piece([king.row, king.column - 2]) == ' ',
        self.find_piece([king.row, king.column - 3]) == ' ',
        self.find_piece([king.row, king.column - 4]).is_a?(Rook) &&
        self.find_piece([king.row, king.column - 4]).color == king.color &&
        self.find_piece([king.row, king.column - 4]).castle == true
      ]
      if conditions.all?
        if check == true
          return true
        end
        rook = self.find_piece([king.row, king.column - 4])
        @arr[rook.row][rook.column] = ' ' 
        rook.update([rook.row, rook.column + 3])

        @arr[king.row][king.column] = ' '
        king.update([king.row, king.column - 2])

        @arr[rook.row][rook.column] = rook
        @arr[king.row][king.column] = king
        return true
      end
    else # Short castle
      conditions = [
        king.castle == true,
        self.find_piece([king.row, king.column + 1]) == ' ',
        self.find_piece([king.row, king.column + 2]) == ' ',
        self.find_piece([king.row, king.column + 3]).is_a?(Rook) &&
        self.find_piece([king.row, king.column + 3]).color == @color &&
        self.find_piece([king.row, king.column + 3]).castle == true
      ]
      if conditions.all?
        if check == true
          return true
        end
        rook = self.find_piece([king.row, king.column + 3])
        @arr[rook.row][rook.column] = ' ' 
        rook.update([rook.row, rook.column - 2])

        @arr[king.row][king.column] = ' '
        king.update([king.row, king.column + 2])

        @arr[rook.row][rook.column] = rook
        @arr[king.row][king.column] = king
        return true
      end
    end
    return false
  end

  def castling?
    result = ''
    if @kings[0] != [] 
      # Short castle
      rook = self.find_piece([7,7])
      if @kings[0] && rook.is_a?(Rook) && rook.castle == true
        result += 'K'
      end
      # Long Castle
      rook = self.find_piece([7,0])
      if @kings[0] && rook.is_a?(Rook) && rook.castle == true
        result += 'Q'
      end
    end
    if @kings[1] != [] 
      rook = self.find_piece([0,7])
      if @kings[0] && rook.is_a?(Rook) && rook.castle == true
        result += 'k'
      end
      rook = self.find_piece([7,7])
      if @kings[0] && rook.is_a?(Rook) && rook.castle == true
        result += 'q'
      end
    end
    if result == ''
      return '-'
    end
    result
  end
end
