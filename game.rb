require_relative 'board'
require_relative 'computer'
require_relative 'human'

class Game
  attr_accessor :board, :player_one, :player_two, :game_mode

  def initialize
    @board = Board.new
    @game_mode = 0
  end

  def start_game
    get_game_mode
    initialize_players
    start_player_vs_player if @game_mode == 1
    start_player_vs_computer if @game_mode == 2
    start_computer_vs_computer if @game_mode == 3
  end

  def start_player_vs_player
    until game_is_over?(board) || tie?(board)
      board.print_board
      get_spot(@player_one)
      unless game_is_over?(board) || tie?(board)
        board.print_board
        get_spot(@player_two)
      end
    end
    board.print_board
    puts "Game over"
  end

  def start_player_vs_computer
    until game_is_over?(board) || tie?(board)
      board.print_board
      get_spot(@player_one)
      unless game_is_over?(board) || tie?(board)
        evaluate_board(@player_two)
      end
    end
    board.print_board
    puts "Game over"
  end

  def start_computer_vs_computer
    until game_is_over?(board) || tie?(board)
      evaluate_board(@player_one)
      unless game_is_over?(board) || tie?(board)
        evaluate_board(@player_two)
      end
    end
    board.print_board
    puts "Game over"
  end

  def initialize_players
    if @game_mode == 1
      @player_one = Human.new('O')
      @player_two = Human.new('X')
    elsif @game_mode == 2
      @player_one = Human.new('O')
      @player_two = Computer.new('X')
      get_difficulty(@player_two)
    elsif @game_mode == 3
      @player_one = Computer.new('O')
      @player_two = Computer.new('X')
      @player_one.set_difficulty('Hard')
      @player_two.set_difficulty('Hard')
    end
  end

  def get_game_mode
    puts '1 - Player vs Player'
    puts '2 - Player vs Computer'
    puts '3 - Computer vs Computer'
    until @game_mode.between?(1, 3)
      print 'Choose a game mode [1-3]: '
      @game_mode = STDIN.gets.chomp.to_i
    end
  end

  def get_difficulty(player)
    until player.difficulty
      print 'Choose the difficulty [Easy, Medium or Hard]: '
      player.set_difficulty(STDIN.gets.chomp.to_s)
    end
    puts "You chose #{player.difficulty}"
  end

  def get_spot(player)
    spot = nil
    until spot
      print 'Enter [0-8]: '
      spot = STDIN.gets.chomp.to_i
      if valid_spot?(spot)
        set_spot(spot, player)
      else
        spot = nil
      end
    end
  end

  def valid_spot?(spot)
    board.tiles[spot] != "X" && board.tiles[spot] != "O" && spot.between?(0, 8)
  end

  def set_spot(spot, player)
    board.tiles[spot] = player.icon
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

  def get_best_move(board, next_player, depth = 0, best_score = {}, player)
    available_spaces = []
    best_move = nil
    board.tiles.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board.tiles[as.to_i] = player.icon
      if game_is_over?(board)
        best_move = as.to_i
        board.tiles[as.to_i] = as
        return best_move
      else
        board.tiles[as.to_i] = player_one.icon
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

  def get_random_move
    spot = rand(9)
  end

  def get_average_move(player)
    random = rand(10)
    if random > 3
      spot = get_best_move(board, player.icon, player)
    else
      spot = get_random_move
    end
    spot
  end

  def evaluate_board(player)
    spot = nil
    until spot
      if board.tiles[4] == "4"
        spot = 4
        board.tiles[spot] = player.icon
      else
        spot = get_random_move if player.difficulty == 'Easy'
        spot = get_average_move(player) if player.difficulty == 'Medium'
        spot = get_best_move(board, player.icon, player) if player.difficulty == 'Hard'
        if board.tiles[spot] != "X" && board.tiles[spot] != "O"
          board.tiles[spot] = player.icon
        else
          spot = nil
        end
      end
    end
  end
end
