require 'byebug'

class Board
  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
    @board_map = {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7
    }
  end

  def place(piece, x ,y, has_moved=true)
    @board[piece.x][piece.y] = "-"
    @board[x][y] = piece
    piece.x = x
    piece.y = y
  end

  def to_s
    board_string = ""
    row_number = 8
    @board.transpose.reverse.map do |row|
      board_string << "#{row_number} "
      row.map do |cell|
        # puts cell
        board_string << "  " if cell == "-"
        board_string << "#{cell.image} " if cell != "-"
      end
      row_number -= 1
      board_string << "\n"
    end
    board_string << "  a b c d e f g h"
    board_string
  end

  def get_piece(player, piece_position)
    piece_coord = piece_position.split('')
    # byebug
    row = @board_map[piece_coord[0]].to_i
    col = piece_coord[1].to_i - 1
    if @board[row][col] != "-"
      return @board[row][col].color == player
    else
      false
    end
  end

  def game_complete?
    false
  end

  def filter_moves(piece, moves_array = [] )
    if piece.type == :pawn
      pawn_filter_moves(moves_array, piece)
    elsif piece.type == :rook
      rook_filter_moves(piece)
    elsif piece.type == :bishop
      bishop_filter_moves(piece)
    elsif piece.type == :queen
      queen_filter_moves(piece)
    elsif piece.type == :king
      king_filter_moves(piece)
    elsif piece.type == :knight
      knight_filter_moves(piece)
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

  def rook_filter_moves(rook)
    filtered_moves = []
    rook_directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    rook_directions.each do |direction|
      filtered_moves += check_next_spot(rook, direction, rook.x, rook.y, 8)
    end
    filtered_moves
  end

  def bishop_filter_moves(bishop)
    filtered_moves = []
    bishop_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    bishop_directions.each do |direction|
      filtered_moves += check_next_spot(bishop, direction, bishop.x, bishop.y, 8)
    end
    filtered_moves
  end
  def queen_filter_moves(queen)
    filtered_moves = []
    queen_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1],[1, 0], [-1, 0], [0, 1], [0, -1]]
    queen_directions.each do |direction|
      filtered_moves += check_next_spot(queen, direction, queen.x, queen.y, 8)
    end
    filtered_moves
  end

  def king_filter_moves(king)
    filtered_moves = []
    king_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1],[1, 0], [-1, 0], [0, 1], [0, -1]]
    king_directions.each do |direction|
      filtered_moves += check_next_spot(king, direction, king.x, king.y, 1)
    end
    filtered_moves
  end

  def knight_filter_moves(knight)
    filtered_moves = []
    knight_directions = [[1, 2], [1, -2], [2, 1], [-2, 1], [-1, -2], [-1, 2], [-2, -1], [2, -1]]
    knight_directions.each do |direction|
      filtered_moves += check_next_spot(knight, direction, knight.x, knight.y, 1)
    end
    filtered_moves
  end


  def check_next_spot(piece, direction, x, y, move_count, move_array = [])
    #direction is a 2 element array [x, y]
    return move_array if move_count == 0
    x_new = x + direction[0]
    y_new = y + direction[1]
    return move_array if x_new > 7 || x_new < 0 || y_new > 7 || y_new < 0  #its off the board
    # byebug
    # return false if @board[x_new][y_new].nil?
    # byebug
    return move_array if @board[x_new][y_new] != "-" && @board[x_new][y_new].color == piece.color
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

  def check?
  end

end


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

  def image
    color == 'white' ? "♙" : "♟"
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

  def image
    color == 'white' ? "♔" : "♚"
  end

  def type
    :king
  end
end

class Queen < Piece

  def image
    color == 'white' ? "♕" : "♛"
  end

  def type
    :queen
  end
end

class Rook < Piece

  def image
    color == 'white' ? "♖" : "♜"
  end

  def type
    :rook
  end

end

class Bishop < Piece

  def image
    color == 'white' ? "♗" : "♝"
  end

  def type
    :bishop
  end
end

class Knight < Piece

  def image
    color == 'white' ? "♘" : "♞"
  end

  def type
    :knight
  end
end




