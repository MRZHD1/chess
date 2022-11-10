require './lib/main.rb'
describe Game do
  it 'Properly considers checks' do
    game = Game.new()
    game.standard_position
    game.move('f2', 'f3');game.move('e7','e6');game.move('g2','g4');game.move('d8','h4')

    expect(game.check).to eql(true)
  end

  it "Doesn't always think it is in check" do
    game = Game.new()
    game.standard_position
    
    expect(game.check).to eql(false)
  end
end