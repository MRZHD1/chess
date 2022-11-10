require_relative 'game'

def save(game)
  fen = serialize(game)
  File.write('./saved_games.txt', "#{fen}\n", mode: 'a')
  puts "Game saved as #{fen}"
end

def load_game()
  
  games = File.read('./saved_games.txt').split("\n")
  games.each_with_index do |game, index|
    puts "\n" + index.to_s + " | #{game}"
  end
  if games != []
    num = gets.chomp
    if ('0'..'100').include?(num) && num.to_i < games.length
      game = deserialize(games[num.to_i])
      puts "Game loaded"
      return game
    end
  end
  puts "Couldn't load game. Using default."
  game = Game.new()
  game.standard_position
  return game
end

def serialize(game)
  fen = ''
  pos = ''
  for row in game.arr
    i = 0
    j = 0
    for piece in row
      if piece != ' '
        if i > 0
          pos += i.to_s
        end
        pos += to_letter(piece)
        i = 0
      else
        i += 1
        if j == 7
          pos += i.to_s
        end
      end
      j += 1
    end
    pos += '/'
  end
  fen += pos[..-2] + ' '
  fen += game.color == 'white' ? 'w ' : 'b '
  fen += game.castling? + ' '
  fen += game.passant + ' '
  fen += "#{game.half_clock} #{game.full_clock}"
  return fen
end

def deserialize(fen)
  game = Game.new()
  fen_arr = fen.split(' ')
  i,j = 0,0
  pieces = fen_arr[0].split('/')
  for row in pieces
    for piece in row.split('')
      if ('0'..'9').to_a.include?(piece)
        piece.to_i.times do
          game.arr[i][j] = ' '
          j += 1
        end
      else
        build_from_letter(piece, [i,j], game)
        j += 1
      end
    end
    i += 1
    j = 0
  end
  game.color = fen_arr[1] == 'b' ? 'black' : 'white'
  if !(fen_arr[2].include?('K')) && !(fen_arr[2].include?('Q'))
    game.kings[0].castle = false
  end
  if !(fen_arr[2].include?('k')) && !(fen_arr[2].include?('q'))
    game.kings[1].castle = false
  end
  game.passant = fen_arr[3]
  game.half_clock = fen_arr[4]
  game.full_clock = fen_arr[5]

  return game
end

def to_letter(piece)
  if piece.is_a?(Pawn)
    return piece.color == 'white' ? 'P' : 'p'
  elsif piece.is_a?(Knight)
    return piece.color == 'white' ? 'N' : 'n'
  elsif piece.is_a?(Bishop)
    return piece.color == 'white' ? 'B' : 'b'
  elsif piece.is_a?(Rook)
    return piece.color == 'white' ? 'R' : 'r'
  elsif piece.is_a?(Queen)
    return piece.color == 'white' ? 'Q' : 'q'
  else
    return piece.color == 'white' ? 'K' : 'k'
  end
end

def build_from_letter(letter, position, game)
  i,j = position
  if letter.downcase == letter # Black Pieces
    if letter == 'p'
      game.new_piece(Pawn, 'black', [i,j])
    elsif letter == 'n'
      game.new_piece(Knight, 'black', [i,j])
    elsif letter == 'b'
      game.new_piece(Bishop, 'black', [i,j])
    elsif letter == 'r'
      game.new_piece(Rook, 'black', [i,j])
    elsif letter == 'q'
      game.new_piece(Queen, 'black', [i,j])
    elsif letter == 'k'
      game.new_piece(King, 'black', [i,j])
    end
  else
    letter = letter.downcase
    if letter == 'p'
      game.new_piece(Pawn, 'white', [i,j])
    elsif letter == 'n'
      game.new_piece(Knight, 'white', [i,j])
    elsif letter == 'b'
      game.new_piece(Bishop, 'white', [i,j])
    elsif letter == 'r'
      game.new_piece(Rook, 'white', [i,j])
    elsif letter == 'q'
      game.new_piece(Queen, 'white', [i,j])
    elsif letter == 'k'
      game.new_piece(King, 'white', [i,j])
    end
  end
end
