require_relative 'chess-model'
require_relative 'chess-view'
# require_relative 'possible-moves-hash'

class Control
  attr_reader :view, :model

  def initialize
    @view = View.new
    @model = Board.new
  end

  def place
    piece = @view.piece.capitalize
    location = @view.location.upcase
    color = @view.color.downcase

    @model.board[location] = Object.const_get(piece).new(color)
  end

  def test_runner
    # @view.start_prompt
    # @view.test_prompt
    # place
    # @view.test_prompt
    # place
    # @view.test_prompt
    # place
    # @view.test_prompt
    # place
    # @view.test_prompt
    # place
    # @view.test_prompt
    # place
    # @view.test_prompt
    # place
    # @view.to_s(@model.board)
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
        return true
      else #if not empty
        if piece_to_move.color == tile_to_go.color
          puts "You cannot move your piece to #{destination}"
          return false
        else
          return true
        end
      end
    end
    return current_valid && destination_valid
  end

  #knight, rook, queen, king
  #white_pawn, black_pawn
  #white_sq_bishop, black_sq_bishop

  def ask_move
    @view.current_prompt
    @view.destination_prompt
    if !valid?(@view.current, @view.destination)
      ask_move
    end
  end

  def runner
    @view.start_prompt
    if @view.start_input.downcase == "y"
      @model.new_game
      @view.to_s(@model.board)

      ask_move

      @model.move_piece(@view.current, @view.destination)

      @view.to_s(@model.board)
    else
      @view.goodbye
    end
  end

end

control = Control.new
control.runner
# p control.model.board
