class Board
  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
  end

  def place(piece, x ,y)
  end

  def to_s
  end

  def filter_moves(moves_array,piece)
  end

  def capture
  end

  def check?
  end
end

# board = Board.new
# board

class Piece
  attr_accessor :x, :y, :movement
  attr_reader :color
  def initialize(color, x, y)
    @color = color
    @x = x
    @y = y
    @movement = false
  end
end

class Pawn < Piece
end

class King < Piece
end

class Queen < Piece
end

class Rook < Piece
end

class Bishop < Piece
end

class Knight < Piece
end


