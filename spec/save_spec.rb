require './lib/main.rb'
describe 'Save' do
  it "can serialize standard position" do
    game = Game.new()
    game.standard_position
    game.build_board
    
    expect(serialize(game)).to eql('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
  end

  it "can serialize after move" do
    game = Game.new()
    game.standard_position
    game.move('e2','e4')
    game.build_board

    expect(serialize(game)).to eql('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1')
  end
end