

class WordGuess
  def initialize
    @guess = ""
    @wrong_count = 5 # Maybe will change this difficulty level
    @word = ["dog", "cat", "person"].sample #make up a dictionary later, hash??
    @used_letters = []
  end

  def guess
    get_input
    check_letter

  end

  # don't mess with this until we refactor
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
  end

  def check_letter

    unless @used_letters.include?(@guess) == false
        puts "You have already guessed this letter!"
        puts "Please guess again!"
        @guess = gets.chomp
    else
         # add letter to used letters array
        @used_letters.push(@guess)
    end

    if @word.include?(@guess)
        for index in 0..@word.length - 1
            if @word[index] == @guess
                # send to game board array
    else
      #guess is wrong
      puts "You have made a terrible guess!"
      puts "How could you pick that letter?!"
      puts "You have #{ @wrong_count - 1 } guesses left."
    end

    


  end




end


class GameBoard

end
