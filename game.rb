require './board.rb'
require './player.rb'

class Game
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end
  
  def play
    until @board.won?
      
      
      begin
        @board.display_board
        move = @player1.get_move
        
        @board[move.first].perform_moves(move.drop(1))
      rescue InvalidMoveError => e
        puts e.message
        
        retry
      end
      
      system("clear")
      
      begin
        @board.display_board
        move = @player2.get_move
        
        @board[move.first].perform_moves(move.drop(1))
      rescue InvalidMoveError => e
        puts e.message
        
        retry
      end
      
      system("clear")
    end
    
    puts "Someone won!"
    
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Player 1", :white)
  player2 = Player.new("Player 2", :black)
  board = Board.new
  
  game = Game.new(board, player1, player2)
  game.play
end