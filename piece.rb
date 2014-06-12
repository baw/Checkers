class Piece
  MOVES_DIFFS = [[1,1], [-1,-1], [1,-1], [-1,1]]
  SYMPOLS = {
    :white => { :man => "\u26C0", :king => "\u26C1" },
    :black => { :man => "\u26C2", :king => "\u26C3" }
  }
  
  def initialize(location, color, board)
    @location, @color, @board = location, color, board
    
    @king = false
  end
  
  def perform_slide(pos)
    row, col = pos
    if moves.include?(pos)
      perform_slide!(pos)
    else
      false
    end
  end
  
  def perform_slide!(pos)
    @board.move(self, @location, pos)
  end
  
  def perform_jump(pos)
    row, col = pos
    if moves.include?(pos)
      
      @board.take_piece
    else
      false
    end
  end
  
  def to_s
    (SYMPOLS[@color][:man] + " ").colorize(:color => @color)
  end
  
  private
  
  def moves
    [].tap do |moves_array|
      MOVES_DIFFS.each do |dy, dx|
        location = [@location[0] + dy, @location[1] + dx]
        
        if @board.on_board?(location) && @board.no_piece_at_location?(location)
          moves_array << location
        end
      end
    end
  end
end