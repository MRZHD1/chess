require 'stockfish'
def bot_move(fen)
  engine = Stockfish::Engine.new('./stockfish-6-linux/stockfish-6-linux/Linux/stockfish_6_x64')
  result = Stockfish::AnalysisParser.new(engine.analyze fen, { :depth => 6 }).best_move_uci
  return result
end