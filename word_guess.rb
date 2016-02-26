
class WordGuess
  # make word so far available to other classes to use
  attr_accessor :word_so_far, :used_letters, :wrong_count

  def initialize
    @guess = ""
    @wrong_count = 5 # Maybe will change this difficulty level
    @word = ["dog", "cat", "person"].sample #make up a dictionary later, hash??
    @used_letters = []
    @word_so_far = #make it ___, figure out how to base this on word.length
  end

  def play_the_game
    while @wrong_count >= 1
      guess
    end
  end


  private
  def guess
    get_input
    check_letter
    word_done
    more_tries
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
              update_word 
        puts "What a great guess!"
        puts "Good job!"
    else
      #guess is wrong
      @wrong_count -= 1
      puts "You have made a terrible guess!"
      puts "How could you pick that letter?!"
      puts "You have #{ @wrong_count } guesses left."
    end
  end

  def more_tries?
      @wrong_count >= 1
  end

  def word_done?
    @word_so_far == @word_so_far
  end


  def update_word
      @word_so_far[index] = @guess
    end
  end
end


class GameBoard

  def initialize
  end

  def update_board
    # get the word_so_far

    # draw the updated board, using word_so_far and used letters 

    # display remaining chances to get it wrong
  end



end
