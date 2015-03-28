require_relative 'chess-model'
require_relative 'chess-view'
require_relative 'possible-moves-hash'
# require 'byebug'

class Control
  attr_reader :view, :model, :promotion_spot

  def initialize
    @view = View.new
    @model = Board.new
    @promotion_spot = nil
  end

  def place
    piece = @view.piece.capitalize
    location = @view.location.upcase
    color = @view.color.downcase
    @model.board[location] = Object.const_get(piece).new(color)
  end

  def valid?(current, destination)
    piece_to_move = @model.board[current]
    tile_to_go = @model.board[destination]

    if piece_to_move == nil
      puts "There's no piece to move at #{current}"
      current_valid = false
    else
      current_valid = true
    end

    if MOVES[piece_to_move.class.name.downcase][current].include?(destination)
      if tile_to_go == nil
        destination_valid = true
      else #if not empty
        if piece_to_move.color == tile_to_go.color
          @view.clear!
          puts "You cannot move your piece to #{destination}"
          destination_valid = false
        else
          destination_valid = true
        end
      end
    else destination_valid = false
    end
    return current_valid && destination_valid
  end

  def check_promote?
    black_promotion = {}
    p @model.board.each_key do |spot|
      if spot.include?('1')
        black_promotion[spot] = piece
      end
    end
    # byebug
    # black_promotion = @model.board.select {|spot, piece| spot[1] == 1}
    # byebug
    # white_promotion = @model.board.select {|spot, piece| spot[1] == 8}

    # black_promotion.each do |spot, piece|
    #   puts piece.class.name
    #   # if piece.class.name == 'Black_pawn'
    #   #   p @promotion_spot << spot
    #   #   return true
    # end

    # white_promotion.each do |spot, piece|
    #   puts piece.class.name
    #   # if piece.class.name == 'White_pawn'
    #   #   p @promotion_spot << spot
    #   #   return true
    #   # end
    # end

    # return false
  end

  def promote

  end

  def ask_move(color)
    @view.clear!
    @view.to_s(@model.board)
    @view.current_prompt(color)
    @view.destination_prompt
    if !valid?(@view.current, @view.destination)
      ask_move(color)
    end
  end

###########

  def between_check(start, dest)
    if move_direction(start, dest) == "linear"
      puts check_linear(start, dest)
      return check_linear(start, dest)
    elsif move_direction(start, dest) == "diagonal"
      determine_diagonal_direction(start, dest)
    end
  end

  def move_direction(start, dest)
    start[0] != dest[0] && start[1] != dest[1] ? "diagonal" : "linear"
  end

  def check_linear(start, dest)
    if start[0] == dest[0]
      if (start[1].ord + 1).chr != dest[1]
        file = start[0]
        ((start[1].ord + 1).chr..dest[1]).each { |rank|
          @model.board[file + rank] == nil ? next : (return "Obstructed")
        start = file + rank}
      end
    elsif start[1] == dest[1]
      if (start[0].ord + 1).chr != dest[0]
        rank = start[1]
        (start[0]..dest[0]).each { |file|
          @model.board[file + rank] == nil ? next : (return "Obstructed")
          start = file + rank}
      end
    end
    "Valid"
  end

  def check_diagonal(start, dest, diag_direction)
    file_increment, rank_increment  = 1, 1 if diag_direction == "up-right"
    file_increment, rank_increment = -1, 1 if diag_direction == "up-left"
    file_increment, rank_increment = 1, -1 if diag_direction == "down-right"
    file_increment, rank_increment = -1, -1 if diag_direction == "down-left"
    current_check = start
    puts (current_check[0].ord + file_increment).chr
    puts (current_check[1].to_i + rank_increment).to_s

    until current_check == dest
      current_check = ((current_check[0].ord + file_increment).chr + (current_check[1].to_i + rank_increment).to_s)
      @model.board[current_check] == nil || current_check == dest ? next : (puts "Obstructed")
    end

  end

  def determine_diagonal_direction(start, dest)
    check_diagonal(start, dest, "up-right") if start[0] < dest[0] && start[1] < dest[1]
    check_diagonal(start, dest, "up-left") if start[0] > dest[0] && start[1] < dest[1]
    check_diagonal(start, dest, "down-right") if start[0] < dest[0] && start[1] > dest[1]
    check_diagonal(start, dest, "down-left") if start[0] > dest[0] && start[1] > dest[1]
  end

###########
  def finished?
    @model.board.values.count {|piece| piece.class.name == 'King'} == 1
  end

  def test_runner

    @view.to_s(@model.board)
    @view.test_prompt
    place
    check_promote?

  end

  def runner
    @view.start_prompt
    if @view.start_input.downcase == "n"
      @view.goodbye
    else
      @model.new_game
      @view.clear!
      @view.to_s(@model.board)
      loop do
        ask_move("WHITE")
        ask_move("WHITE") until between_check(@view.current, @view.destination) == "Valid"
        @model.move_piece(@view.current, @view.destination)
        @view.to_s(@model.board)

        if finished?
          @view.winner!("WHITE")
          break
        end

        ask_move("BLACK")
        ask_move("BLACK") until between_check(@view.current, @view.destination) == "Valid"
        @model.move_piece(@view.current, @view.destination)
        @view.clear!
        @view.to_s(@model.board)
        if finished?
          @view.winner!("BLACK")
          break
        end
      end
    end
  end

end

control = Control.new
control.runner
# control.test_runner
