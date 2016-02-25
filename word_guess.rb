

class WordGuess
  def initialize
    @guess = ""
    @wrong_count = 5 # Maybe will change this difficulty level
    @word = ["dog", "cat", "person"].sample #make up a dictionary later, hash??
  end

  def guess
    get_input
    check_letter

  end

  def get_input

    # figure out the alphabet array and how to use a range
    @alphabet_array = ['A', 'B', 'C']

    puts "What letter do you guess?"
    @guess = gets.chomp.upcase

    # this checks if the guess is a single character and if that character is a letter!
    while @guess.length != 1 || @alphabet_array.include?(@guess) == false
        puts "Your guess is unusable, please guess again!"
        @guess = gets.chomp
    end

    # echoes guess to user
    puts "Your guess was #{ @guess }."

    #
  end

  def check_letter

    if @word.include?(@guess)

      #if yes, check indexes

    else
      #guess is wrong

    end


  end




end


class GameBoard

end
