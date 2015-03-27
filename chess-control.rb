require_relative 'chess-model'
require_relative 'chess-view'
require_relative 'possible-moves-hash'

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
   @view.start_prompt
    if @view.start_input.downcase == "n"
      @view.goodbye
    else
      @model.new_game
      @view.clear!
      @view.to_s(@model.board)

      loop do
        ask_move("WHITE")
        @model.move_piece(@view.current, @view.destination)
        @view.clear!
        @view.to_s(@model.board)
        break if finished?

        ask_move("BLACK")
        @model.move_piece(@view.current, @view.destination)
        @view.clear!
        @view.to_s(@model.board)
        break if finished?
      end
    end
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

  def ask_move(color)
    @view.current_prompt(color)
    @view.destination_prompt
    if !valid?(@view.current, @view.destination)
      ask_move(color)
    end
  end

  def finished?
    @model.board.values.count {|piece| piece.class.name == 'King'} == 1
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
        @model.move_piece(@view.current, @view.destination)
        @view.clear!
        @view.to_s(@model.board)
        if finished?
          @view.winner!("WHITE")
          break
        end

        ask_move("BLACK")
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
