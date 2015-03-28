require 'byebug'

class Board
  attr_accessor :turn, :game_complete, :board_state_hash
  attr_reader :board

  def initialize
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
    @turn = 0
    @game_complete = false
    @board_state_hash = {}
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
    if piece == "-"
      @board[x][y] = "-"
    else
      @board[piece.x][piece.y] = "-"
      @board[x][y] = piece
      piece.x = x
      piece.y = y
      piece.has_moved = has_moved
      piece.turn = @turn
    end
  end

  def to_s
    board_string = ""
    row_number = 8
    @board.transpose.reverse.map do |row|
      board_string << "#{row_number} "
      row.map do |cell|
        board_string << ". " if cell == "-"
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
    filter_moves_array.sort.each_with_index do |move, index|
      move_list << @board_map.invert[move[0]].to_s
      move_list << "#{move[1] + 1}"
      move_list << ", " if index != filter_moves_array.length - 1
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

  def game_check
    king_count = 0
    @board.each do |row|
      row.each do |cell|
        next if cell == "-"
        king_count += 1 if cell.class == King
      end
    end
    @game_complete = true if king_count == 1
  end

  def save_board_state
    save_state = @board.flatten.dup
    save_state.map! do |piece|
      if piece != "-"
        piece = "#{piece.color} #{piece.class}"
      end
    end
    if @board_state_hash.has_key?(save_state)
      @board_state_hash[save_state] += 1
    else
      @board_state_hash[save_state] = 1
    end
  end

  def filter_moves(piece)
    if piece.class == Pawn
      pawn_filter_moves(piece)
    elsif piece.class == King
      king_filter_moves(piece)
    else
      piece_filter_moves(piece, piece.directions, piece.move_count)
    end
  end

  def piece_filter_moves(piece, directions, piece_move_count)
    filtered_moves = []
    directions.each do |direction|
      filtered_moves += check_next_spot(piece, direction, piece.x, piece.y, piece_move_count)
    end
    filtered_moves
  end

  def pawn_filter_moves(pawn)
    invalid_moves = []
    pawn.color == 'white' ? (y_move = 1) : (y_move = -1)
    pawn.has_moved ? (pawn_move_count = 1) : (pawn_move_count = 2)
    filtered_moves = check_next_spot(pawn, pawn.directions, pawn.x, pawn.y, pawn_move_count)
    #capture_array is calculating if the diagonal moves are valid
    capture_array = [[pawn.x + 1, pawn.y + y_move], [pawn.x - 1, pawn.y + y_move]]
    capture_array.each do |move|
      x_new, y_new = move
      #it was the double move
      #turn = turn + 1
      if x_new > 7 || x_new < 0
        invalid_moves << move
      # elsif @board[pawn.x + 1][pawn.y].class == :pawn && @board[pawn.x + 1][pawn.y].turn == (turn + 1)
      elsif @board[x_new][y_new] == "-"
        invalid_moves << move
      elsif @board[x_new][y_new] != "-" && @board[x_new][y_new].color == pawn.color
        invalid_moves << move
      end
    end
    filtered_attacks = capture_array - invalid_moves
    filtered_moves + filtered_attacks
  end

  def king_filter_moves(king)
    king_directions = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    filter_moves = piece_filter_moves(king, king_directions, 1)
    #castling conditions
    if @board[7][0] == "-"
      filter_moves
    elsif !king.has_moved && king.color == 'white' && @board[7][0].class == Rook && @board[7][0].has_moved == false && @board[5][0] == "-" && @board[6][0] == "-"
      filter_moves << [6, 0]
    end
    if @board[0][0] == "-"
      filter_moves
    elsif !king.has_moved && king.color == 'white' && @board[0][0].class == Rook && @board[0][0].has_moved == false && @board[1][0] == "-" && @board[2][0] == "-" && @board[3][0] == "-"
      filter_moves << [2, 0]
    end
    if @board[0][7] == "-"
      filter_moves
    elsif !king.has_moved && king.color == 'black' && @board[0][7].class == Rook && @board[0][7].has_moved == false && @board[1][7] == "-" && @board[2][7] == "-" && @board[3][7] == "-"
      filter_moves << [2, 7]
    end
    if @board[7][7] == "-"
      filter_moves
    elsif !king.has_moved && king.color == 'black' && @board[7][7].class == Rook && @board[7][7].has_moved == false && @board[5][7] == "-" && @board[6][7] == "-"
      filter_moves << [6, 7]
    end
    filter_moves
  end

  def remove_bad_moves(filtered_moves, piece)
    invalid_moves = []
    original_x = piece.x
    original_y = piece.y
    filtered_moves.each do |move|
      stored_spot = @board[move[0]][move[1]]
      place(piece, move[0], move[1])
      invalid_moves << move if check?(piece.color)
      # filtered_moves.delete(move) if check?(piece.color)}
      place(piece, original_x, original_y)
      place(stored_spot, move[0], move[1])
    end
    filtered_moves - invalid_moves
    # filtered_moves
  end

  def no_moves?(player)
    @board.each do |row|
      row.each do |piece|
        next if piece == "-"
        next if piece.color != player
        move_array = remove_bad_moves(filter_moves(piece), piece)
        return false if !move_array.empty?
      end
    end
    true
  end


  def check_next_spot(piece, direction, x, y, move_count, move_array = [])
    return move_array if move_count == 0
    x_new = x + direction[0]
    y_new = y + direction[1]
    return move_array if x_new > 7 || x_new < 0 || y_new > 7 || y_new < 0  #its off the board
    return move_array if @board[x_new][y_new] != "-" && @board[x_new][y_new].color == piece.color
    if @board[x_new][y_new] == "-"
      move_array << [x_new, y_new]
      check_next_spot(piece, direction, x_new, y_new, move_count - 1, move_array)
    elsif @board[x_new][y_new] != "-" && @board[x_new][y_new] != piece.color && piece.class != Pawn
      move_array << [x_new, y_new]
    end
    move_array
  end

  def check?(player)
    @board.each do |row|
      row.each do |piece|
        next if piece == "-"
        next if piece.color == player
        piece_move_array = filter_moves(piece)
        piece_move_array.each do |position|
          position_piece = @board[position[0]][position[1]]
          next if position_piece == "-"
          return true if position_piece.class == King
        end
      end
    end
    false
  end

end

class Piece
  attr_accessor :x, :y, :has_moved, :turn
  attr_reader :color, :directions, :move_count

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
    color == 'white' ? (y_move = 1) : (y_move = -1)
    @directions = [0, y_move]
  end

  def image
    color == 'white' ? "\u2659" : "\u265F"
  end

end

class King < Piece

  def initialize(color, x, y)
    super(color, x, y)
    @directions = [[1, 1], [-1, 1], [1, -1], [-1, -1],[1, 0], [-1, 0], [0, 1], [0, -1]]
    @move_count = 1
  end

  def image
    color == 'white' ? "\u2654" : "\u265A"
  end

end

class Queen < Piece

  def initialize(color, x, y)
    super(color, x, y)
    @directions = [[1, 1], [-1, 1], [1, -1], [-1, -1],[1, 0], [-1, 0], [0, 1], [0, -1]]
    @move_count = 8
  end

  def image
    color == 'white' ? "\u2655" : "\u265B"
  end

end

class Rook < Piece

  def initialize(color, x, y)
    super(color, x, y)
    @directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    @move_count = 8
  end

  def image
    color == 'white' ? "\u2656" : "\u265C"
  end

end

class Bishop < Piece

  def initialize(color, x, y)
    super(color, x, y)
    @directions = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    @move_count = 8
  end

  def image
    color == 'white' ? "\u2657" : "\u265D"
  end

end

class Knight < Piece

  def initialize(color, x, y)
    super(color, x, y)
    @directions = [[1, 2], [1, -2], [2, 1], [-2, 1], [-1, -2], [-1, 2], [-2, -1], [2, -1]]
    @move_count = 1
  end

  def image
    color == 'white' ? "\u2658" : "\u265E"
  end

end


