require 'colorize'

class WordGuess
  # make word so far available to other classes to use
  attr_accessor :word_so_far, :used_letters, :wrong_count

  def initialize
    @guess = ""
    @wrong_count = 5 # Maybe will change this difficulty level
    @word = ["dog", "cat", "person"].sample #make up a dictionary later, hash??
    @alphabet_array = ("A".."Z").to_a
    @used_letters = []
    @word_so_far = "___"#make it ___, figure out how to base this on word.length
    #Add dictionary 
  end

  def play_the_game
    until @wrong_count == 0
      guess
    end
    lose_game
  end


  private
  def guess
    get_input
    check_letter
    if word_done?
      win_game
    end
    if !more_tries?
      lose_game
    end
  end

  # don't mess with this until we refactor
  def get_input

    # figure out the alphabet array and how to use a range
    

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
            end
        end
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

  def win_game
    #call board drawing
    puts "YAY! YOU WIN! Your prize is an elephant hotdog!"
    exit
  end

  def lose_game
    #call board drawing
    puts "OH, NO! YOU LOSE!! Your prize is stinky socks..."
    exit
  end
end


class GameBoard

  def initialize
  end

  def update_board
    case # name the variable 
    when 5
      puts pac_man_one + dot_one + dot_one + dot_one + dot_one
      puts pac_man_two + dot_two + dot_two + dot_two + dot_two
      puts pac_man_thr + dot_thr + dot_thr + dot_thr + dot_thr
      puts pac_man_fou + dot_fou + dot_fou + dot_fou + dot_fou
      puts pac_man_fiv + dot_fiv + dot_fiv + dot_fiv + dot_fiv
      puts pac_man_six + dot_six + dot_six + dot_six + dot_six
    when 4
      puts pac_man_one + dot_one + dot_one + dot_one + ghost_one
      puts pac_man_two + dot_two + dot_two + dot_two + ghost_two.colorize(:green)
      puts pac_man_thr + dot_thr + dot_thr + dot_thr + ghost_thr.colorize(:green)
      puts pac_man_fou + dot_fou + dot_fou + dot_fou + ghost_fou.colorize(:green)
      puts pac_man_fiv + dot_fiv + dot_fiv + dot_fiv + ghost_fiv.colorize(:green)
      puts pac_man_six + dot_six + dot_six + dot_six + ghost_six
    when 3
      puts dot_one + dot_one + ghost_one + ghost_one + pac_man_one
      puts pac_man_two + dot_two + dot_two + ghost_two.colorize(:red) + ghost_two.colorize(:green)
      puts pac_man_thr + dot_thr + dot_thr + ghost_thr.colorize(:red) + ghost_thr.colorize(:green)
      puts pac_man_fou + dot_fou + dot_fou + ghost_fou.colorize(:red) + ghost_fou.colorize(:green)
      puts pac_man_fiv + dot_fiv + dot_fiv + ghost_fiv.colorize(:red) + ghost_fiv.colorize(:green)
      puts dot_six + dot_six + ghost_six + ghost_six + pac_man_six
    when 2
      puts ghost_one + ghost_one + ghost_one + pac_man_one + dot_one
      puts pac_man_two + dot_two + ghost_two.colorize(:blue) + ghost_two.colorize(:red) + ghost_two.colorize(:green)
      puts pac_man_thr + dot_thr + ghost_thr.colorize(:blue) + ghost_thr.colorize(:red) + ghost_thr.colorize(:green)
      puts pac_man_fou + dot_fou + ghost_fou.colorize(:blue) + ghost_fou.colorize(:red) + ghost_fou.colorize(:green)
      puts pac_man_fiv + dot_fiv + ghost_fiv.colorize(:blue) + ghost_fiv.colorize(:red) + ghost_fiv.colorize(:green)
      puts ghost_six + ghost_six + ghost_six + pac_man_six + dot_six
    when 1
      puts pac_man_one + ghost_one + ghost_one + ghost_one + ghost_one
      puts pac_man_two + ghost_two.colorize(:magenta) + ghost_two.colorize(:blue) + ghost_two.colorize(:red) + ghost_two.colorize(:green)
      puts pac_man_thr + ghost_thr.colorize(:magenta) + ghost_thr.colorize(:blue) + ghost_thr.colorize(:red) + ghost_thr.colorize(:green)
      puts pac_man_fou + ghost_fou.colorize(:magenta) + ghost_fou.colorize(:blue) + ghost_fou.colorize(:red) + ghost_fou.colorize(:green)
      puts pac_man_fiv + ghost_fiv.colorize(:magenta) + ghost_fiv.colorize(:blue) + ghost_fiv.colorize(:red) + ghost_fiv.colorize(:green)
      puts pac_man_six + ghost_six + ghost_six + ghost_six + ghost_six
    when 0
      puts ghost_one + ghost_one + ghost_one + ghost_one + ghost_one
      puts ghost_two.colorize(:yellow).blink + ghost_two.colorize(:magenta).blink + ghost_two.colorize(:blue).blink + ghost_two.colorize(:red).blink + ghost_two.colorize(:green).blink
      puts ghost_thr.colorize(:yellow).blink + ghost_thr.colorize(:magenta).blink + ghost_thr.colorize(:blue).blink + ghost_thr.colorize(:red).blink + ghost_thr.colorize(:green).blink
      puts ghost_fou.colorize(:yellow).blink + ghost_fou.colorize(:magenta).blink + ghost_fou.colorize(:blue).blink + ghost_fou.colorize(:red).blink + ghost_fou.colorize(:green).blink
      puts ghost_fiv.colorize(:yellow).blink + ghost_fiv.colorize(:magenta).blink + ghost_fiv.colorize(:blue).blink + ghost_fiv.colorize(:red).blink + ghost_fiv.colorize(:green).blink
      puts ghost_six + ghost_six + ghost_one + ghost_six + ghost_six
    end
  end



end
