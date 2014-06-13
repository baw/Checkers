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
      request_move(@player1)
      
      request_move(@player2)
    end
    
    puts "Someone won!"
  end
  
  def request_move(player)
    begin
      @board.display_board
      move = player.get_move
      
      @board[move.first].perform_moves(move.drop(1), player.piece_color)
    rescue InvalidMoveError => e
      puts "Invalid Move: Please try again."
      
      retry
    rescue DifferentPieceColorPlayerColor => e
      puts "You can only move pieces of your color"
      
      retry
    end
    
    system("clear")
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Player 1", :white)
  player2 = Player.new("Player 2", :black)
  board = Board.new
  
  game = Game.new(board, player1, player2)
  game.play
end