require './lib/main.rb'
describe Game do
  it 'Properly considers checks' do
    game = Game.new()
    game.standard_position
    game.move('f2', 'f3');game.move('e7','e6');game.move('g2','g4');game.move('d8','h4')
    expect(game.check?).to eql(true)
  end

  it "Doesn't always think it is in check" do
    game = Game.new()
    game.standard_position
    
    expect(game.check?).to eql(false)
  end

  it "Doesn't allow moves that would cause checks" do
    game = Game.new()
    game.new_piece(King, 'white', [6,4])
    game.new_piece(Pawn, 'white', [6,5])
    game.new_piece(Queen, 'black', [5,7])

    before = [game.arr, game.color]
    game.move('e2','f3')
    after = [game.arr, game.color]

    expect(before == after).to eql(true)
  end

  it "Can long castle" do
    game = Game.new()
    game.new_piece(Pawn, 'white', [6,0])
    game.new_piece(King, 'black', [0,4])
    game.new_piece(Rook, 'black', [0,0])

    game.move('a2','a4');game.move('e8','c8')
    
    expect(game.find_piece([0,2]).is_a?(King) && game.find_piece([0,3]).is_a?(Rook)).to eql(true)
  end

  it "Can short castle" do
    game = Game.new()
    game.new_piece(Pawn, 'white', [6,0])
    game.new_piece(King, 'black', [0,4])
    game.new_piece(Rook, 'black', [0,7])

    game.move('a2','a4');game.move('e8', 'g8')
    game.build_board

    expect(game.find_piece([0,6]).is_a?(King) && game.find_piece([0,5]).is_a?(Rook)).to eql(true)
  end
end