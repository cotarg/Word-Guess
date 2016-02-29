require 'colorize'

class WordGuess

  # creates a game object that contains all the game methods
  # sets the word
  def initialize
    @guess = "" # initializes w/ empty guess
    @wrong_count = 5 # Maybe will change this difficulty level
    @difficulty = "" # init with empty difficulty so player can choose
    @pick_word = {easy: ["dog", "cat", "star"].sample,
      medium: ["pizza", "input", "coder"].sample,
      hard: ["birthday", "computation", "ubiquitous"].sample} # selects a word for each difficulty
    @word = "" # placeholder for word we will be guessing
    @alphabet_array = ("A".."Z").to_a # letters to check guesses against
    @used_letters = [] # place holder for guessed letters
    @word_so_far = "" # placeholder to hold the word as it is guessed
    @bad_prize = ["stinky socks", "moldy tofu", "rotten eggs", "more homework", "dirty diapers"].sample
    @good_prize = ["elephant hotdog", "invisible pineapple", "expensive whiskey", "customized puppet of yourself"].sample
  end


  # this method enables playing the game
  def play_the_game
    pick_a_word
    update_board
    until @wrong_count == 0
      guess
    end
    lose_game
  end

  private

  # this method defines the difficulty level and sets the word to guess
  def pick_a_word
    if @word == ""
      puts "What difficulty would you like to play at? There's easy(E), medium(M), or hard(H)!"
      print "Difficulty: "
      @difficulty = gets.chomp.upcase
      if @difficulty == "E" || @difficulty == "EASY"
        @word = @pick_word[:easy]
        @word = @word.upcase
      elsif @difficulty == "M" || @difficulty == "MEDIUM"
        @word = @pick_word[:medium]
        @word = @word.upcase
      elsif @difficulty == "H" || @difficulty == "HARD"
        @word = @pick_word[:hard]
        @word = @word.upcase
      else
        # if they try to enter anything except a difficulty level
        # the game throws up and goes home
        puts "I don't know what you want, please start over!"
        exit
      end
      @word_so_far = "_" * @word.length
    end
  end

  # this method operates getting guesses and checking them.
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

  # this method actually gets the input
  def get_input
    puts "What letter do you guess?"
    @guess = gets.chomp.upcase

    # this checks if you guessed the right word.
    while @guess.length > 1
      if @guess == @word.upcase
        win_game
      else
        #second time we use this- refactor into a method?
        @wrong_count -= 1
        puts "You have made a terrible guess!"
        puts "How could you pick that letter?!"
        @used_letters.push(@guess)
        update_board
        puts "You have #{ @wrong_count } guesses left."
        @guess = gets.chomp.upcase
      end
    end

    # this checks if the guess is a single character and if that character is a letter!
    while @guess.length != 1 || @alphabet_array.include?(@guess) == false
        puts "Your guess is unusable, please guess again!"
        @guess = gets.chomp.upcase
    end
    # echoes guess to user
    puts "Your guess was #{ @guess }."
  end

  # this checks if the letter is in the word, and if you already guessed it.
  def check_letter

    unless @used_letters.include?(@guess) == false
        puts "You have already guessed this letter!"
        puts "Please guess again!"
        @guess = gets.chomp.upcase
    else
        # add letter to used letters array
        @used_letters.push(@guess)
    end

    if @word.upcase.include?(@guess)
      for index in 0..@word.length - 1
        if @word[index].upcase == @guess
          # update_word #took it out of method just to check variable
          @word_so_far[index] = @guess
        end
      end
      puts "What a great guess!"
      puts "Good job!"
      update_board
    else
      #guess is wrong
      @wrong_count -= 1
      puts "You have made a terrible guess!"
      puts "How could you pick that letter?!"
      update_board
      puts "You have #{ @wrong_count } guesses left."
    end
  end

  # this checks if you have more wrong guesses available
  def more_tries?
      @wrong_count >= 1
  end

  def word_done?
    @word_so_far == @word.upcase
  end

  # this prints the winning game board
  def win_game
    #call board drawing
    @wrong_count = 6
    update_board
    message = "YAY! YOU WIN! Your prize is an "
    message2 = "#{@good_prize}"
    puts message.colorize(:yellow) + message2.colorize(:magenta)
    system "say", message
    system "say", message2
    exit
  end

  # this prints the losing game board
  def lose_game
    #call board drawing
    wrong_count = 0
    # update_board
    message = "OH, NO! YOU LOSE!! Your prize is #{@bad_prize}..."
    puts message.colorize(:red)
    puts "The correct word was: #{@word.colorize(:yellow)}"
    system "say", message
    exit
  end

  # this prints the game boards and updates them.
  def update_board
    ghost_one = "=======".colorize(:cyan)
    ghost_two = "   .-. "
    ghost_thr = "  |OO |"
    ghost_fou = "  |   |"
    ghost_fiv = "  '^^^'"
    ghost_six = "=======".colorize(:cyan)

    pac_man_one = "=========".colorize(:cyan)
    pac_man_two = "    .--. ".colorize(:yellow)
    pac_man_thr = "   / _.-'".colorize(:yellow)
    pac_man_fou = "   |  '-.".colorize(:yellow)
    pac_man_fiv = "    '--' ".colorize(:yellow)
    pac_man_six = "=========".colorize(:cyan)

    dot_one = "=========".colorize(:cyan)
    dot_two = "         "
    dot_thr = "   .''.  "
    dot_fou = "   '..'  "
    dot_fiv = "         "
    dot_six = "=========".colorize(:cyan)

    case @wrong_count
    when 6
      puts pac_man_one + pac_man_one + pac_man_one + pac_man_one + pac_man_one
      puts pac_man_two.blink + pac_man_two.blink + pac_man_two.blink + pac_man_two.blink + pac_man_two.blink
      puts pac_man_thr.blink + pac_man_thr.blink + pac_man_thr.blink + pac_man_thr.blink + pac_man_thr.blink
      puts pac_man_fou.blink + pac_man_fou.blink + pac_man_fou.blink + pac_man_fou.blink + pac_man_fou.blink
      puts pac_man_fiv.blink + pac_man_fiv.blink + pac_man_fiv.blink + pac_man_fiv.blink + pac_man_fiv.blink
      puts pac_man_six + pac_man_six + pac_man_six + pac_man_six + pac_man_six
      puts @word_so_far

    when 5
      puts pac_man_one + dot_one + dot_one + dot_one + dot_one
      puts pac_man_two + dot_two + dot_two + dot_two + dot_two
      puts pac_man_thr + dot_thr + dot_thr + dot_thr + dot_thr
      puts pac_man_fou + dot_fou + dot_fou + dot_fou + dot_fou
      puts pac_man_fiv + dot_fiv + dot_fiv + dot_fiv + dot_fiv
      puts pac_man_six + dot_six + dot_six + dot_six + dot_six
      puts @word_so_far
      puts "The letters you have guessed so far are: #{@used_letters}"
    when 4
      puts pac_man_one + dot_one + dot_one + dot_one + ghost_one
      puts pac_man_two + dot_two + dot_two + dot_two + ghost_two.colorize(:green)
      puts pac_man_thr + dot_thr + dot_thr + dot_thr + ghost_thr.colorize(:green)
      puts pac_man_fou + dot_fou + dot_fou + dot_fou + ghost_fou.colorize(:green)
      puts pac_man_fiv + dot_fiv + dot_fiv + dot_fiv + ghost_fiv.colorize(:green)
      puts pac_man_six + dot_six + dot_six + dot_six + ghost_six
      puts @word_so_far
      puts "The letters you have guessed so far are: #{@used_letters}"

    when 3
      puts dot_one + dot_one + ghost_one + ghost_one + pac_man_one
      puts pac_man_two + dot_two + dot_two + ghost_two.colorize(:red) + ghost_two.colorize(:green)
      puts pac_man_thr + dot_thr + dot_thr + ghost_thr.colorize(:red) + ghost_thr.colorize(:green)
      puts pac_man_fou + dot_fou + dot_fou + ghost_fou.colorize(:red) + ghost_fou.colorize(:green)
      puts pac_man_fiv + dot_fiv + dot_fiv + ghost_fiv.colorize(:red) + ghost_fiv.colorize(:green)
      puts dot_six + dot_six + ghost_six + ghost_six + pac_man_six
      puts @word_so_far
      puts "The letters you have guessed so far are: #{@used_letters}"

    when 2
      puts ghost_one + ghost_one + ghost_one + pac_man_one + dot_one
      puts pac_man_two + dot_two + ghost_two.colorize(:blue) + ghost_two.colorize(:red) + ghost_two.colorize(:green)
      puts pac_man_thr + dot_thr + ghost_thr.colorize(:blue) + ghost_thr.colorize(:red) + ghost_thr.colorize(:green)
      puts pac_man_fou + dot_fou + ghost_fou.colorize(:blue) + ghost_fou.colorize(:red) + ghost_fou.colorize(:green)
      puts pac_man_fiv + dot_fiv + ghost_fiv.colorize(:blue) + ghost_fiv.colorize(:red) + ghost_fiv.colorize(:green)
      puts ghost_six + ghost_six + ghost_six + pac_man_six + dot_six
      puts @word_so_far
      puts "The letters you have guessed so far are: #{@used_letters}"

    when 1
      puts pac_man_one + ghost_one + ghost_one + ghost_one + ghost_one
      puts pac_man_two + ghost_two.colorize(:magenta) + ghost_two.colorize(:blue) + ghost_two.colorize(:red) + ghost_two.colorize(:green)
      puts pac_man_thr + ghost_thr.colorize(:magenta) + ghost_thr.colorize(:blue) + ghost_thr.colorize(:red) + ghost_thr.colorize(:green)
      puts pac_man_fou + ghost_fou.colorize(:magenta) + ghost_fou.colorize(:blue) + ghost_fou.colorize(:red) + ghost_fou.colorize(:green)
      puts pac_man_fiv + ghost_fiv.colorize(:magenta) + ghost_fiv.colorize(:blue) + ghost_fiv.colorize(:red) + ghost_fiv.colorize(:green)
      puts pac_man_six + ghost_six + ghost_six + ghost_six + ghost_six
      puts @word_so_far
      puts "The letters you have guessed so far are: #{@used_letters}"

    when 0
      puts ghost_one + ghost_one + ghost_one + ghost_one + ghost_one
      puts ghost_two.colorize(:yellow).blink + ghost_two.colorize(:magenta).blink + ghost_two.colorize(:blue).blink + ghost_two.colorize(:red).blink + ghost_two.colorize(:green).blink
      puts ghost_thr.colorize(:yellow).blink + ghost_thr.colorize(:magenta).blink + ghost_thr.colorize(:blue).blink + ghost_thr.colorize(:red).blink + ghost_thr.colorize(:green).blink
      puts ghost_fou.colorize(:yellow).blink + ghost_fou.colorize(:magenta).blink + ghost_fou.colorize(:blue).blink + ghost_fou.colorize(:red).blink + ghost_fou.colorize(:green).blink
      puts ghost_fiv.colorize(:yellow).blink + ghost_fiv.colorize(:magenta).blink + ghost_fiv.colorize(:blue).blink + ghost_fiv.colorize(:red).blink + ghost_fiv.colorize(:green).blink
      puts ghost_six + ghost_six + ghost_one + ghost_six + ghost_six
      puts @word_so_far

    else
      puts "I don't know what's going on!"
      exit

    end
  end
end

game = WordGuess.new
puts "Welcome to the Pac-Man Word Guess! Please play starting now!"
game.play_the_game
