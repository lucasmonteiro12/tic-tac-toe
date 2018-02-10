class Board
  attr_accessor :tiles

  def initialize
    @tiles = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def print_board
    puts " #{@tiles[0]} | #{@tiles[1]} | #{@tiles[2]} \n===+===+===\n #{@tiles[3]} | #{@tiles[4]} | #{@tiles[5]} \n===+===+===\n #{@tiles[6]} | #{@tiles[7]} | #{@tiles[8]} \n"
  end
end
