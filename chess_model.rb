require 'byebug'

class Board
  attr_accessor :turn
  attr_reader :board

  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
    @turn = 0
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

  def place(piece, x, y, has_moved = false)
    @board[piece.x][piece.y] = "-"
    @board[x][y] = piece
    piece.x = x
    piece.y = y
    piece.has_moved = has_moved
    piece.turn = @turn
  end

  def to_s
    board_string = ""
    row_number = 8
    @board.transpose.reverse.map do |row|
      board_string << "#{row_number} "
      row.map do |cell|
        board_string << "  " if cell == "-"
        board_string << "#{cell.image} " if cell != "-"
      end
      row_number -= 1
      board_string << "\n"
    end
    board_string << "  a b c d e f g h"
    board_string
  end

  #create a string of all moves in chess notation
  def convert_to_chess_notation(filter_moves_array)
    move_list = ""
    filter_moves_array.sort.each do |move|
      move_list << @board_map.invert[move[0]].to_s
      move_list << "#{move[1] + 1}, "
    end
    move_list
  end

  def validate_piece(player, piece_position)
    row, col = split_coordinates(piece_position)
    if @board[row][col] != "-"
      return @board[row][col].color == player
    else
      false
    end
  end

  def get_piece(piece_position)
    row, col = split_coordinates(piece_position)
    @board[row][col]
  end

  def split_coordinates(piece_position)
    piece_coord = piece_position.split('')
    row = @board_map[piece_coord[0]].to_i
    col = piece_coord[1].to_i - 1
    [row, col]
  end

  def get_row(position)
    piece_coord = position.split('')
    @board_map[piece_coord[0]].to_i
  end

  def get_col(position)
    piece_coord = position.split('')
    piece_coord[1].to_i - 1
  end

  def game_complete?
    king_count = 0
    @board.each do |row|
      row.each do |cell|
        next if cell == "-"
        king_count += 1 if cell.type == :king
      end
    end
    return true if king_count == 1
    false
  end

  def filter_moves(piece, moves_array = [] )
    if piece.type == :pawn
      pawn_filter_moves(piece)
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

  def pawn_filter_moves(pawn)
    invalid_moves = []
    pawn.color == 'white' ? (y_move = 1) : (y_move = -1)
    direction = [0, y_move]
    pawn.has_moved ? (pawn_move_count = 1) : (pawn_move_count = 2)
    filtered_moves = check_next_spot(pawn, direction, pawn.x, pawn.y, pawn_move_count)
    #capture_array is calculating if the diagonal moves are valid
    capture_array = [[pawn.x + 1, pawn.y + y_move], [pawn.x - 1, pawn.y + y_move]]
    capture_array.each do |move|
      x_new, y_new = move
      #it was the double move
      #turn = turn + 1
      if x_new > 7 || x_new < 0
        invalid_moves << move
      # elsif @board[pawn.x + 1][pawn.y].type == :pawn && @board[pawn.x + 1][pawn.y].turn == (turn + 1)
      elsif @board[x_new][y_new] == "-"
        invalid_moves << move
      elsif @board[x_new][y_new] != "-" && @board[x_new][y_new].color == pawn.color
        invalid_moves << move
      end
    end
    filtered_attacks = capture_array - invalid_moves
    filtered_moves + filtered_attacks
  end

  def rook_filter_moves(rook)
    rook_directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    piece_filter_moves(rook, rook_directions, 8)
  end

  def bishop_filter_moves(bishop)
    bishop_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    piece_filter_moves(bishop, bishop_directions, 8)
  end

  def queen_filter_moves(queen)
    queen_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1],[1, 0], [-1, 0], [0, 1], [0, -1]]
    piece_filter_moves(queen, queen_directions, 8)
  end

  def king_filter_moves(king)
    king_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    pre_filter_moves = piece_filter_moves(king, king_directions, 1)
    #castling conditions
    if !king.has_moved && king.color == 'white' && @board[7][0].type == :rook && @board[7][0].has_moved == false && @board[5][0] == "-" && @board[6][0] == "-"
      pre_filter_moves << [6, 0]
    end
    if !king.has_moved && king.color == 'white' && @board[0][0].type == :rook && @board[0][0].has_moved == false && @board[1][0] == "-" && @board[2][0] == "-" && @board[3][0] == "-"
      pre_filter_moves << [2, 0]
    end
    if !king.has_moved && king.color == 'black' && @board[0][7].type == :rook && @board[0][7].has_moved == false && @board[1][7] == "-" && @board[2][7] == "-" && @board[3][7] == "-"
      pre_filter_moves << [2, 7]
    end
    if !king.has_moved && king.color == 'black' && @board[7][7].type == :rook && @board[7][7].has_moved == false && @board[5][7] == "-" && @board[6][7] == "-"
      pre_filter_moves << [6, 7]
    end
    pre_filter_moves
  end

  def knight_filter_moves(knight)
    knight_directions = [[1, 2], [1, -2], [2, 1], [-2, 1], [-1, -2], [-1, 2], [-2, -1], [2, -1]]
    piece_filter_moves(knight, knight_directions, 1)
  end

  def piece_filter_moves(piece, directions, piece_move_count)
    filtered_moves = []
    directions.each do |direction|
      filtered_moves += check_next_spot(piece, direction, piece.x, piece.y, piece_move_count)
    end
    filtered_moves
  end


  def check_next_spot(piece, direction, x, y, move_count, move_array = [])
    return move_array if move_count == 0
    x_new = x + direction[0]
    y_new = y + direction[1]
    return move_array if x_new > 7 || x_new < 0 || y_new > 7 || y_new < 0  #its off the board
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

  def check?(player, any_board = @board)
    any_board.each do |row|
      row.each do |piece|
        next if piece == "-"
        next if piece.color == player
        piece_move_array = filter_moves(piece) #array of arrays
        piece_move_array.each do |position|
          position_piece = any_board[position[0]][position[1]]
          next if position_piece == "-"
          return true if position_piece.type == :king
        end
      end
    end
    false
  end

end

class Piece
  attr_accessor :x, :y, :has_moved, :turn
  attr_reader :color

  def initialize(color, x, y)
    @color = color
    @x = x
    @y = y
    @has_moved = false
  end

end

class Pawn < Piece

  attr_accessor :double_move

  def initialize(color, x, y)
    super(color, x, y)
    @double_move = false
  end

  def image
    color == 'white' ? "♙" : "♟"
  end

  def type
    :pawn
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


