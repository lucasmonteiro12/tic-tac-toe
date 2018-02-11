require_relative '../game'

describe Game do
  game = Game.new

  describe 'initialize' do
    it 'initializes the board' do
      expect(game.board).to_not be_nil
    end

    it 'initializes the computer' do
      expect(game.computer).to_not be_nil
    end

    it 'initializes the human' do
      expect(game.human).to_not be_nil
    end
  end

  describe '#game_is_over?' do
    it 'does not end the game without equal icons in a row' do
      game.board.tiles = ['X', 'X', 'O', 'O', 'X', 'X', 'O', 'O', '8']
      expect(game.game_is_over?(game.board)).to eq(false)
    end

    it 'ends the game with 3 equal icons in a row' do
      game.board.tiles = ['X', 'X', 'X', '3', '4', '5', '6', '7', '8']
      expect(game.game_is_over?(game.board)).to eq(true)
    end
  end

  describe '#tie?' do
    it 'ends the game with a full board with no winners' do
      game.board.tiles = ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O']
      expect(game.tie?(game.board)).to eq(true)
    end
  end

  describe '#set_spot' do
    it 'puts the human icon (O) into the designated spot' do
      game.set_spot(2)
      expect(game.board.tiles[2]).to eq('O')
    end
  end

  describe '#valid_spot?' do
    context 'with a value between 0 and 8' do
      it 'returns true' do
        game.board.tiles = ['0', '1', '2', '3', '4', '5', '6', '7', '8']
        expect(game.valid_spot?(5)).to eq(true)
      end
    end

    context 'with a value over 8' do
      it 'returns false' do
        game.board.tiles = ['0', '1', '2', '3', '4', '5', '6', '7', '8']
        expect(game.valid_spot?(12)).to eq(false)
      end
    end

    context 'with an already picked spot' do
      it 'returns false' do
        game.board.tiles = ['0', '1', '2', '3', '4', 'X', '6', '7', '8']
        expect(game.valid_spot?(5)).to eq(false)
      end
    end
  end
end
