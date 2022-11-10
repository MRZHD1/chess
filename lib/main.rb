require_relative 'colors'
require_relative 'pieces'
require_relative 'game'
require_relative 'stockfish'

game = Game.new()
game.standard_position
# game.build_board
bmove = ''

loop do
  game.build_board
  if bmove.length > 0
    puts "Stockfish has moved #{bmove}"
  end
  var = gets.chomp
  game.move(var[..1], var[2..]) 
  if game.check_mate?
    puts "Checkmate!"
    break
  end
  if game.color == 'black'
    bmove = bot_move(game.serialize)
    game.move(bmove[..1], bmove[2..])
  end
  if game.check_mate?
    puts bmove
    break
  end
end

# e2e4 g1f3 d1e2 e4e5 e5d6