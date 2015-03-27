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
    if @model.board[current] == nil
      puts "There's no piece to move at #{current}"
      current_valid = false
    else
      puts "it's passing as true"
      current_valid = true
    end

    if @model.board[destination] != nil
      puts "You cannot move your piece to #{destination}"
      destination_valid = false
    else
      puts "it's passing as true"
      destination_valid =  true
    end

    return current_valid && destination_valid
  end

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
