alphabet_array = []

class WordGuess
  def initialize
    @guess = ""
  end

  def guess
    puts "What letter do you guess?"
    @guess = gets.chomp.upcase
    
    while @guess.length > 1 || alphabet_array.include?(@guess) == false
        puts "Your guess is unusable, please guess again!"
        @guess = gets.chomp
    end


    puts @guess


  end


end


class GameBoard

end
