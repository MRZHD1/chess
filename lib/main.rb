require_relative 'colors'
require_relative 'pieces'
require_relative 'game'

game = Game.new()
# game.new_piece(King, 'white', [7,4])
# game.new_piece(Pawn, 'white', [6,5])
# game.new_piece(Queen, 'black', [5,6])

# loop do
#   game.build_board
#   var = gets.chomp
#   game.move(var[..1], var[2..]) 
# end