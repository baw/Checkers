require "./errors.rb"

class Piece
  attr_reader :color, :location
  
  MOVES_DIFFS = [[1,1], [-1,-1], [1,-1], [-1,1]]
  SYMPOLS = { :man => "\u2609", :king => "\u2687" }
  
  def initialize(location, color, board)
    @location, @color, @board = location, color, board
    
    @king = false
  end
  
  def perform_moves(positions)
    if valid_move_seq?(positions)
      perform_moves!(positions)
    else
      raise InvalidMoveError
    end
  end
  
  def perform_slide(pos)
    row, col = pos
    if moves(@location).include?(pos)
      perform_slide!(pos)
    else
      false
    end
  end
  
  def perform_jump(positions)
    dup_board = @board.dup
    
    previous_location = @location
    move_result = positions.all? do |position|
      square_location = square_inbetween(previous_location, position)
      
      if moves(previous_location, true).include?(square_location) &&
         moves(square_location, true).include?(position)
         
        results = dup_board[previous_location].perform_jump!(previous_location, [position])
        previous_location = position
      else
        return false
      end
      
      results
    end
    
    if move_result
      perform_jump!(@location, positions)
    else
      false
    end
  end
  
  def to_s
    rank = @king ? :king : :man
    
    (SYMPOLS[rank] + " ").colorize(:color => @color)
  end
  
  protected
  
  def perform_moves!(positions)
    if positions.length == 1
      results = perform_slide(positions.first)
      
      results = perform_jump(positions) unless results
      
      results
    else
      perform_jump(positions)
    end
  end
  
  def perform_slide!(pos)
    @board.move(self, @location, pos)
    @location = pos
    
    true
  end
  
  def perform_jump!(beginning, positions)
    previous_location = beginning
    positions.each_with_index do |position, index|
      square_location = square_inbetween(previous_location, position)
      
      @board.take_piece(square_location)
      @board.move(self, @location, position)
      @location = position
      
      previous_location = position
    end
    
    true
  end
  
  private
  
  def valid_move_seq?(positions)
    dup_board = @board.dup
    
    dup_board[@location].perform_moves!(positions)
  end
  
  def moves(from_location, allow_take = false)
    [].tap do |moves_array|
      MOVES_DIFFS.each do |dy, dx|
        location = [from_location[0] + dy, from_location[1] + dx]
        
        if @board.on_board?(location)
          if @board.no_piece_at_location?(location) || allow_take
            if right_direction?(location) || @king
              moves_array << location
            end
          end
        end
      end
    end
  end
  
  def right_direction?(new_location)
    if @color == :white
      @location[0] >= new_location[0]
    else
      new_location[0] >= @location[0]
    end
  end
  
  def square_inbetween(start_location, end_location)
    debugger if start_location == [5,2] && end_location == [1,6]
    dy = (end_location.first - start_location.first) / 2
    dx = (end_location.last - start_location.last) / 2
    
    [start_location.first + dy, start_location.last + dx]
  end
end