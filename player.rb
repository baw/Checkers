class Player
  def initialize(name, piece_color)
    @name, @piece_color = name, piece_color
    
    puts "Welcome to checkers, #{@name}"
    puts "Your color is #{@piece_color}"
  end
  
  def get_move
    puts "#{@name}, your move please"
    gets.chomp.split(' ').map! { |move| move.split(',').map!(&:to_i) }
  end
end