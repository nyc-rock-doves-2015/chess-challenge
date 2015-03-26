require 'byebug'

class Board
  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
  end

  def place(piece, x ,y)
    @board[x][y] = piece
    piece.x = x
    piece.y = y
  end

  def to_s
  end

  def filter_moves(moves_array, piece)
    if piece.type == :pawn
      pawn_filter_moves(moves_array, piece)
    end
  end

  def pawn_filter_moves(moves_array, pawn)
    bad_moves = []
    if pawn.color == 'white'
      direction = [0, 1]
    else
      direction = [0, -1]
    end
    pawn.has_moved ? (move_count = 1) : (move_count = 2)
    filtered_moves = check_next_spot(pawn, direction, pawn.x, pawn.y, move_count)

    moves_array.map do |move|
      x_new = move[0]
      y_new = move[1]
      if @board[x_new][y_new] != "-" &&  x_new == pawn.x
        bad_moves << move
      elsif @board[x_new][y_new] == "-" && x_new != pawn.x
        bad_moves << move
      elsif @board[x_new][y_new] != "-" && x_new != pawn.x && @board[x_new][y_new].color == pawn.color
        bad_moves << move
      end
    end
    filtered_attacks = moves_array - bad_moves
    filtered_moves + filtered_attacks
  end


  def check_next_spot(piece, direction, x, y, move_count, move_array = [])
    #direction is a 2 element array [x, y]
    return move_array if move_count == 0
    return false if x > 7 || x < 0 || y > 7 || y < 0  #its off the board
    x_new = x + direction[0]
    y_new = y + direction[1]
    return false if @board[x_new][y_new] != "-" && @board[x_new][y_new].color == piece.color
    if @board[x_new][y_new] == "-"
      move_array << [x_new, y_new]
      open = check_next_spot(piece, direction, x_new, y_new, move_count - 1, move_array)
      if open
        return move_array
      else
        move_array.pop
        return false
      end
    elsif @board[x_new][y_new] != "-" && @board[x_new][y_new] != piece.color && piece.type != :pawn
      move_array << [x_new, y_new]
    end
    move_array
  end

  def capture
  end

  def check?
  end
end

# board = Board.new
# board

class Piece
  attr_accessor :x, :y, :has_moved
  attr_reader :color
  def initialize(color, x, y)
    @color = color
    @x = x
    @y = y
    @has_moved = false
  end
end

class Pawn < Piece

  def move_count
    2
  end

  def type
    :pawn
  end

  def possible_moves
    @color == 'white' ? (y_move = 1) : (y_move = -1)
    [[x+1, y + y_move], [x-1, y + y_move]]
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




