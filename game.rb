require_relative 'board'
require_relative 'computer'
require_relative 'human'

class Game
  attr_accessor :board, :computer, :human

  def initialize
    @board = Board.new
    @computer = Computer.new('X')
    @human = Human.new('O')
  end

  def start_game
    until game_is_over?(board) || tie?(board)
      board.print_board
      get_spot
      unless game_is_over?(board) || tie?(board)
        evaluate_board
      end
    end
    board.print_board
    puts "Game over"
  end

  def get_spot
    spot = nil
    print 'Enter [0-8]:'
    until spot
      spot = gets.chomp.to_i
      if board.tiles[spot] != "X" && board.tiles[spot] != "O"
        set_spot(spot)
      else
        spot = nil
      end
    end
  end

  def set_spot(spot)
    board.tiles[spot] = human.icon
  end

  def game_is_over?(board)
    [board.tiles[0], board.tiles[1], board.tiles[2]].uniq.length == 1 ||
    [board.tiles[3], board.tiles[4], board.tiles[5]].uniq.length == 1 ||
    [board.tiles[6], board.tiles[7], board.tiles[8]].uniq.length == 1 ||
    [board.tiles[0], board.tiles[3], board.tiles[6]].uniq.length == 1 ||
    [board.tiles[1], board.tiles[4], board.tiles[7]].uniq.length == 1 ||
    [board.tiles[2], board.tiles[5], board.tiles[8]].uniq.length == 1 ||
    [board.tiles[0], board.tiles[4], board.tiles[8]].uniq.length == 1 ||
    [board.tiles[2], board.tiles[4], board.tiles[6]].uniq.length == 1
  end

  def tie?(board)
    board.tiles.all? { |s| s == "X" || s == "O" }
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.tiles.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board.tiles[as.to_i] = computer.icon
      if game_is_over?(board)
        best_move = as.to_i
        board.tiles[as.to_i] = as
        return best_move
      else
        board.tiles[as.to_i] = human.icon
        if game_is_over?(board)
          best_move = as.to_i
          board.tiles[as.to_i] = as
          return best_move
        else
          board.tiles[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def evaluate_board
    spot = nil
    until spot
      if board.tiles[4] == "4"
        spot = 4
        board.tiles[spot] = computer.icon
      else
        spot = get_best_move(board, computer.icon)
        if board.tiles[spot] != "X" && board.tiles[spot] != "O"
          board.tiles[spot] = computer.icon
        else
          spot = nil
        end
      end
    end
  end
end
