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
end