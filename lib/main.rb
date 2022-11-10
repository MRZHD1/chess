require_relative 'colors'
require_relative 'pieces'
require_relative 'game'

game = Game.new()
game.standard_position
game.build_board

# loop do
#   game.build_board
#   var = gets.chomp
#   game.move(var[..1], var[2..]) 
# end