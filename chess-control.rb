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
    @view.start_prompt
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
    if @user_input.downcase == "y"
    end
  end

end

control = Control.new
control.test_runner
# p control.model.board
