require_relative 'chess-model'
require_relative 'chess-view'

class Control
  attr_reader :view, :model

  def initialize
    @view = View.new
    @model = Board.new
  end

  def place
    piece = @view.piece.capitalize
    location = @view.location.downcase
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

  def runner
    @view.start_prompt
    if @view.user_input.downcase == "y"
      @model.new_game
      @view.to_s(@model.board)
    else
      @view.goodbye
    end
  end

end

control = Control.new
control.runner
# p control.model.board
