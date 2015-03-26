class Board
  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
  end

  def place(piece, x ,y)
    @board[x][y] = piece
  end

  def to_s
  end

  def filter_moves(moves_array, piece)
    bad_moves = []
    moves_array.map do |move|
      x_new = move[0]
      y_new = move[1]
      if @board[x_new][y_new] != "-" &&  x_new == piece.x
        bad_moves << move
      elsif @board[x_new][y_new] == "-" && x_new != piece.x
        bad_moves << move
      elsif @board[x_new][y_new] != "-" && x_new != piece.x && @board[x_new][y_new].color == piece.color
        bad_moves << move
      end
    end
    filtered_moves = moves_array - bad_moves
    filtered_moves
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
    color == 'white' ? (y_move = 1) : (y_move = -1)
    [[x, y + y_move], [x+1, y + y_move], [x-1, y + y_move]]
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




