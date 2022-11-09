require_relative 'colors'
require_relative 'pieces'
require_relative 'game'

game = Game.new()


8.times do |i|
  # Adding Pawns
  white_pawn = Pawn.new([6,i],'white',game)
  game.add_piece(white_pawn, [6,i])

  black_pawn = Pawn.new([1,i],'black',game)
  game.add_piece(black_pawn, [1,i])
  # Adding Rooks
  if i == 0 || i == 7
    white_rook = Rook.new([7, i], 'white', game)
    game.add_piece(white_rook, [7,i])

    black_rook = Rook.new([0, i], 'black', game)
    game.add_piece(black_rook, [0,i])
  end
  # Adding Bishops
  if i == 1 || i == 6
    white_bishop = Bishop.new([7, i], 'white', game)
    game.add_piece(white_bishop, [7,i])

    black_bishop = Bishop.new([0, i], 'black', game)
    game.add_piece(black_bishop, [0,i])
  end
  # Adding Knights
  if i == 2 || i == 5
    white_knight = Knight.new([7, i], 'white', game)
    black_knight = Knight.new([0, i], 'black', game)

    game.add_piece(white_knight, [7, i])
    game.add_piece(black_knight, [0, i])
  end
  # Adding Queens
  if i == 3
    white_queen = Queen.new([7, i], 'white', game)
    black_queen = Queen.new([0, i], 'black', game)

    game.add_piece(white_queen, [7, i])
    game.add_piece(black_queen, [0, i])
  end
  # Adding Kings
  if i == 4
    white_king = King.new([7,i], 'white', game)
    black_king = King.new([0,i], 'black', game)

    game.add_piece(white_king, [7, i])
    game.add_piece(black_king, [0, i])
  end
end

game.build_board

# loop do
#   game.build_board
#   var = gets.chomp
#   game.move(var[..1], var[2..]) 
# end