require_relative '../board'

describe Board do
  board = Board.new

  describe 'initialize' do
    it 'initializes the board with 9 spaces' do
      expect(board.tiles.size).to eq(9)
    end
  end

  describe '#print_board' do
    it "prints the board correctly formatted" do
      text = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \n"
      expect{ board.print_board }.to output(text).to_stdout
    end
  end
end
