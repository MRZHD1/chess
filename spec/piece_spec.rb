require './lib/main.rb'
describe Piece do
  describe Pawn do
    it "Moves up to 2 steps at the start" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      piece = game.find_piece([6,0])
      expect(piece.moves.sort).to eql([[5,0], [4,0]].sort)
    end

    it "Gets blocked by friendly piece" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      game.new_piece(Pawn, 'white', [5,0])
      piece = game.find_piece([6,0])
      expect(piece.moves).to eql([])
    end

    it "Gets blocked by enemy piece" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      game.new_piece(Pawn, 'black', [5,0])
      piece = game.find_piece([6,0])
      expect(piece.moves).to eql([])
    end
    
    it "Doesn't attack friendly piece" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      game.new_piece(Pawn, 'white', [5,1])
      piece = game.find_piece([6,0])
      expect(piece.moves.sort).to eql([[5,0],[4,0]].sort)
    end

    it "Attacks enemy piece" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      game.new_piece(Pawn, 'black', [5,1])
      piece = game.find_piece([6,0])
      expect(piece.moves.sort).to eql([[5,0],[4,0],[5,1]].sort)
    end

    it "En Passants" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      game.new_piece(Pawn, 'black', [1,1])
      game.new_piece(Pawn, 'black', [1,0])
      game.move('a2','a4');game.move('a7','a6');game.move('a4','a5');game.move('b7','b5')
      piece = game.find_piece([3,0])
      expect(piece.moves).to eql([[2,1]])
    end

    it "Doesn't always En Passant" do
      game = Game.new()
      game.new_piece(Pawn, 'white', [6,0])
      game.new_piece(Pawn, 'black', [1,1])
      game.move('a2','a4');game.move('b7','b6');game.move('a4','a5');game.move('b6','b5')
      piece = game.find_piece([3,0])
      expect(piece.moves).to eql([[2,0]])
    end
  end

  describe Bishop do
    it "Works on Diagonals" do
      game = Game.new()
      game.new_piece(Bishop, 'white', [4,3])
      piece = game.find_piece([4,3])
      expect(piece.moves.sort).to eql([
        [7,0],[6,1],[5,2], # Bottom Left
        [3,4],[2,5],[1,6],[0,7], # Upper Right
        [3,2],[2,1],[1,0], # Upper Left
        [5,4],[6,5],[7,6] #Bottom Right
      ].sort)
    end

    it "Works when blocked by a friendly piece" do
      game = Game.new()
      game.new_piece(Bishop, 'white', [4,3])
      piece = game.find_piece([4,3])
      game.new_piece(Pawn, 'white', [5,2])

      expect(piece.moves.sort).to eql([
        [3,4],[2,5],[1,6],[0,7], # Upper Right
        [3,2],[2,1],[1,0], # Upper Left
        [5,4],[6,5],[7,6] #Bottom Right
      ].sort)
    end

    it "Works when blocked by an enemy piece" do 
      game = Game.new()
      game.new_piece(Bishop, 'white', [4,3])
      piece = game.find_piece([4,3])
      game.new_piece(Pawn, 'black', [5,2])

      expect(piece.moves.sort).to eql([
        [5,2], # Enemy Piece
        [3,4],[2,5],[1,6],[0,7], # Upper Right
        [3,2],[2,1],[1,0], # Upper Left
        [5,4],[6,5],[7,6] #Bottom Right
      ].sort)
    end
  end

  describe Rook do
    it "Works on straight lines" do
      game = Game.new()
      game.new_piece(Rook, 'black', [4,3])
      piece = game.find_piece([4,3])

      expect(piece.moves().sort).to eql([
        [3,3],[2,3],[1,3],[0,3], # Up
        [5,3],[6,3],[7,3], # Down
        [4,2],[4,1],[4,0], # Left
        [4,4],[4,5],[4,6],[4,7] # Right
      ].sort)
    end
    it "Works when blocked by friendly" do
      game = Game.new()
      game.new_piece(Rook, 'black', [4,3])
      game.new_piece(Rook, 'black', [5,3])
      piece = game.find_piece([4,3])

      expect(piece.moves().sort).to eql([
        [3,3],[2,3],[1,3],[0,3], # Up
        # Down
        [4,2],[4,1],[4,0], # Left
        [4,4],[4,5],[4,6],[4,7] # Right
      ].sort)
    end
    it "Works when blocked by enemy" do
      game = Game.new()
      game.new_piece(Rook, 'black', [4,3])
      game.new_piece(Rook, 'white', [5,3])
      piece = game.find_piece([4,3])

      expect(piece.moves().sort).to eql([
        [3,3],[2,3],[1,3],[0,3], # Up
        [5,3],# Down
        [4,2],[4,1],[4,0], # Left
        [4,4],[4,5],[4,6],[4,7] # Right
      ].sort)
    end
  end
  
  describe Knight do
    it "Has all correct moves" do
      game = Game.new()
      game.new_piece(Knight, 'white', [7,2])
      piece = game.find_piece([7,2])

      expect(piece.moves().sort).to eql([
        [5,1],[6,0],[6,4],[5,3]
      ].sort)
    end

    it "Gets blocked by a friendly" do
      game = Game.new()
      game.new_piece(Knight, 'white', [7,2])
      game.new_piece(Pawn, 'white', [5,3])
      piece = game.find_piece([7,2])

      expect(piece.moves().sort).to eql([
        [5,1],[6,0],[6,4]
      ].sort)
    end

    it "Doesn't get blocked by an enemy" do
      game = Game.new()
      game.new_piece(Knight, 'white', [7,2])
      game.new_piece(Pawn, 'black', [5,3])
      piece = game.find_piece([7,2])

      expect(piece.moves().sort).to eql([
        [5,1],[6,0],[6,4],[5,3]
      ].sort)
    end
  end

  describe Queen do
    it "Works on diagonals and straights" do
      game = Game.new()
      game.new_piece(Queen, 'black', [4,3])
      piece = game.find_piece([4,3])

      expect(piece.moves().sort).to eql([
        [3,3],[2,3],[1,3],[0,3], # Up
        [5,3],[6,3],[7,3], # Down
        [4,2],[4,1],[4,0], # Left
        [4,4],[4,5],[4,6],[4,7], # Right
        [7,0],[6,1],[5,2], # Bottom Left
        [3,4],[2,5],[1,6],[0,7], # Upper Right
        [3,2],[2,1],[1,0], # Upper Left
        [5,4],[6,5],[7,6] #Bottom Right
      ].sort)
    end

    it "Works when blocked by friendlies" do 
      game = Game.new()
      game.new_piece(Queen, 'black', [4,3])
      game.new_piece(Queen, 'black', [5,3])
      game.new_piece(Pawn, 'black', [5,2])
      piece = game.find_piece([4,3])

      expect(piece.moves().sort).to eql([
        [3,3],[2,3],[1,3],[0,3], # Up
        # Down
        [4,2],[4,1],[4,0], # Left
        [4,4],[4,5],[4,6],[4,7], # Right
        # Bottom Left
        [3,4],[2,5],[1,6],[0,7], # Upper Right
        [3,2],[2,1],[1,0], # Upper Left
        [5,4],[6,5],[7,6] #Bottom Right
      ].sort)
    end
    
    it "Works when blocked by enemies" do
      game = Game.new()
      game.new_piece(Queen, 'black', [4,3])
      game.new_piece(Queen, 'black', [5,3])
      game.new_piece(Pawn, 'white', [5,2])
      piece = game.find_piece([4,3])

      expect(piece.moves().sort).to eql([
        [3,3],[2,3],[1,3],[0,3], # Up
        # Down
        [4,2],[4,1],[4,0], # Left
        [4,4],[4,5],[4,6],[4,7], # Right
        [3,4],[2,5],[1,6],[0,7], # Upper Right
        [3,2],[2,1],[1,0], # Upper Left
        [5,2], # Bottom Left
        [5,4],[6,5],[7,6] #Bottom Right
      ].sort)
    end
  end

  describe King do 
    it "Has all the correct moves" do
      game = Game.new()
      game.new_piece(King, 'white', [7,4])
      game.move('e1','e2')
      piece = game.find_piece([6,4])

      expect(piece.moves.sort).to eql([
        [5,5], [5,4], [5,3],
        [6,5], [6,3],
        [7,5], [7,4], [7,3]
      ].sort)
    end

    it "Gets blocked by friendlies" do
      game = Game.new()
      game.new_piece(King, 'white', [7,4])
      game.new_piece(Pawn, 'white', [5,3])
      game.move('e1','e2')
      piece = game.find_piece([6,4])

      expect(piece.moves.sort).to eql([
        [5,5], [5,4],
        [6,5], [6,3],
        [7,5], [7,4], [7,3]
      ].sort)
    end

    it "Doesn't get blocked by enemies" do
      game = Game.new()
      game.new_piece(King, 'white', [7,4])
      game.new_piece(Pawn, 'black', [5,3])
      game.move('e1','e2')
      piece = game.find_piece([6,4])

      expect(piece.moves.sort).to eql([
        [5,5], [5,4], [5,3],
        [6,5], [6,3],
        [7,5], [7,4], [7,3]
      ].sort)
    end
  end
end
