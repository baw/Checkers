require "piece.rb"

describe Piece do
  describe "#initialize" do
    it "creates piece with location entered"
    
    it "creates piece with color entered"
  end
  
  describe "#promote" do
    it "promotes a piece to a king"
  end
  
  describe "#perform_moves" do
    context "when a one move is submitted" do
      it "should try to perform a slide move first"
      
      it "should try to perform a jump move if a slide move fails"
    end
    
    context "when a mulitple moves are submitted" do
      it "performs jump moves"
    end
  end
  
  describe "#to_s" do
    context "when a piece is a king" do
      it "should return the proper character for a king"
    end
    
    context "when a piece is a man" do
      it "should return the proper character for a man"
    end
  end
end