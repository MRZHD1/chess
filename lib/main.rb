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

end

game.build_board