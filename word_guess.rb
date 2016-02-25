class WordGuess
  def initialize
    @guess = ""
  end

  def guess
    puts "What letter do you guess?"
    @guess = gets.chomp
    puts @guess
  end


end


class GameBoard

end
