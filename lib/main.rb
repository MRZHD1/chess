require_relative 'colors'
require_relative 'pieces'
require_relative 'game'
require_relative 'save'
require_relative 'stockfish'

bot = false
bmove = ''
puts "Click Enter to start a new game, or 1 to load a game"
if gets.chomp == '1'
  game = load_game()
else
  puts "If you want to fight stockfish, type 1. Otherwise click Enter for two players"
  if gets.chomp == '1'
    bot = true
  end
  game = Game.new()
  game.standard_position
end

loop do
  game.build_board
  if bmove.length > 0
    puts "Stockfish has moved #{bmove}"
  end
  var = gets.chomp
  if var == 'quit' || var == 'exit'
    puts "Game quitted!"
    break
  elsif var == 'save'
    save(game)
    break
  end
  system('clear')
  game.move(var[..1], var[2..]) 
  if game.check_mate?
    game.build_board
    puts "Checkmate!"
    break
  end
  if game.color == 'black'
    bmove = bot_move(serialize(game))
    game.move(bmove[..1], bmove[2..])
  end
  if game.check_mate?
    game.build_board
    puts bmove + ", Checkmate!"
    break
  end
end

