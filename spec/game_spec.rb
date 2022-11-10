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

    expect(before == after). to eql(true)
  end
end