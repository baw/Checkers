require "board.rb"

describe Board do
  describe "#initialize" do
    it "creates the matrix with peices" do
      board = Board.new
      
      [0,1,2,3,6,7,8,9].each do |row|
        cols = row % 2 == 0 ? [1,3,5,7,9] : [0,2,4,6,8]
        
        cols.each do |col|
          expect(board[[row, col]]).to_not be_nil
        end
      end
    end
    
    it "creates the matrix without peices if false is passed in" do
      board = Board.new(false)
      
      (0...10).each do |row|
        (0...10).each do |col|
          expect(board[[row, col]]).to be_nil
        end
      end
    end
  end
  
  describe "#[]" do
    it "returns the piece at the location entered"
  end
  
  describe "#[]=" do
    it "changes the piece at the location entered with what is supplied"
  end
  
  describe "#on_board?" do
    
  end
  
  describe "#no_piece_at_location?" do
    
  end
  
  describe "#move" do
    
  end
  
  describe "#take_piece" do
    
  end
  
  describe "#dup" do
    
  end
  
  describe "#won?" do
    
  end
end