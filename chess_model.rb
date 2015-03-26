class Board
  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
  end

  def place(piece, x ,y)
    @board[x][y] = piece
  end

  def to_s
  end

  def filter_moves(moves_array,piece)
    moves_array.delete_if do |move|
      x_new = move[0]
      y_new = move[1]
      @board[x_new][y_new] != "-" && x_new == 0
      @board[x_new][y_new].color == self.color && x_new != 0

    end
    moves_array
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
  def possible_moves
    [[x, y+1], [x+1, y+1], [x-1, y+1]]
  end
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




