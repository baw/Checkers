require 'colorize'

require './piece.rb'

class Board
  def initialize(add_pieces = true)
    @matrix = Array.new(10) { Array.new(10, nil) }
    
    add_pieces_to_matrix if add_pieces
  end
  
  def [](pos)
    row, col = pos
    @matrix[row][col]
  end
  
  def []=(pos, new_piece)
    row, col = pos
    @matrix[row][col] = new_piece
  end
  
  def display_board
    puts "   0 1 2 3 4 5 6 7 8 9"
    @matrix.each_with_index do |row, index1|
      print "#{index1} "
      
      row.each_index do |index2|
        if index1.even?
          color = index2.even? ? "" : :red
        else
          color = index2.odd?  ? "" : :red
        end
        
        if @matrix[index1][index2].nil?
          print "  ".colorize(:background => color)
        else
          print @matrix[index1][index2].to_s.colorize(:background => color)
        end
      end
      
      puts
    end
    
    nil
  end
  
  def on_board?(location)
    row, col = location
    (0...@matrix.length).include?(row) && (0...@matrix[row].length).include?(col)
  end
  
  def no_piece_at_location?(location)
    row, col = location
    
    @matrix[row][col].nil?
  end
  
  def move(piece, from, to)
    from_row, from_col = from
    to_row, to_col = to
    
    @matrix[from_row][from_col] = nil
    @matrix[to_row][to_col] = piece
  end
  
  def take_piece(location)
    row, col = location
    
    @matrix[row][col] = nil
  end
  
  def dup
    new_board = Board.new(false)
    
    @matrix.each_with_index do |row, index1|
      row.each_with_index do |piece, index2|
        next if piece.nil?
        
        new_board[[index1, index2]] =
            Piece.new([index1, index2], piece.color, new_board)
      end
    end
    
    new_board
  end
  
  private
  
  def add_pieces_to_matrix
    (0...@matrix.length).each do |index1|
      next if [4,5].include?(index1)
      
      color = (0...4).include?(index1) ? :black : :white
      
      (0...@matrix[index1].length).each do |index2|
        next if index1.even? && index2.even?
        next if index1.odd? && index2.odd?
        
        @matrix[index1][index2] = Piece.new([index1, index2], color, self)
      end
    end
  end
end