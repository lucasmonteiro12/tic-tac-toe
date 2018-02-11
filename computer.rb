require_relative 'player'

class Computer < Player
  attr_reader :difficulty

  def set_difficulty(difficulty)
    if difficulty == 'Easy' || difficulty == 'Medium' || difficulty == 'Hard'
      @difficulty = difficulty
    end
  end
end
