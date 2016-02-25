alphabet_array = ["A"..."Z"]

class WordGuess
  def initialize
    @guess = ""
  end

  def guess
    puts "What letter do you guess?"
    @guess = gets.chomp.upcase
    
    # this checks if the guess is a single character and if that character is a letter!
    while @guess.length != 1 || alphabet_array.include?(@guess) == false
        puts "Your guess is unusable, please guess again!"
        @guess = gets.chomp
    end

    # echoes guess to user
    puts "Your guess was #{ @guess }."


  end


end


class GameBoard

end
