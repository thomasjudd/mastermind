$game_over = false
$colors = ["red", "orange", "yellow", "green", "blue", "purple"]

class Game
  attr_accessor :size
  attr_accessor :answer
  attr_accessor :black_pegs
  attr_accessor :white_pegs

  def initialize
    @black_pegs = 0
    @white_pegs = 0
    @size = 4
    #create a four color unique code
    shuffled = $colors.shuffle
    @answer = shuffled[0...4]
  end
#black pegs are exact matches
#white pegs mean that there is a color match that is not an exact match
  def evaluate_guess(guess)
    resp = {}
    resp['black_pegs'] = 0
    resp['white_pegs'] = 0

    guess.each_with_index do |color, index|
      puts "color: #{color}, answer[index]: #{answer[index]}"
      if answer[index] == color
        @black_pegs += 1
        puts "exact match"
      elsif answer[index..-1].include? color
        puts "included color"
        @white_pegs += 1 
      end
    end
    resp['black_pegs'] = @black_pegs
    resp['white_pegs'] = @white_pegs
    puts "guess: #{guess}"
    return resp
  end
end

class Player
  def self.make_guess(size)
    guess = []
    puts "enter a guess one color at a time followed by the enter key"
    puts "the available color choices: 'red', 'orange', 'yellow', 'green', 'blue', 'purple'"
    size.times do
      puts "Enter a color ('red', 'orange', 'yellow', 'green', 'blue', 'purple')"
      color = gets.chomp
      if $colors.include?(color)
        puts "#{color} is a valid color!"
        guess << color
      else
        puts "#{color} isn't invalid color"
        return self.make_guess(size) if not $colors.include?(color)
      end
    end
    puts "this is your guess #{guess}"
    return guess
  end
end

mygame = Game.new

while not $game_over
  guess = Player.make_guess(mygame.size)
  print "guess: #{guess}\n"
  response = mygame.evaluate_guess(guess)
  print "white pegs: #{mygame.white_pegs}, black pegs: #{mygame.black_pegs}\n"
  print "answer:#{mygame.answer}\n"
  if response['black_pegs'] == 4
    puts 'you win!'
    game_over = true
  end
end
