require_relative 'chess-model'
require_relative 'chess-view'

class Control
  attr_reader :model, :view
  def initialize
    @view = View.new
    @model = Board.new
  end

  def place
    piece = @view.piece.capitalize
    location = @view.location.downcase
    color = @view.color.downcase

    @model.board[location] = Object.const_get(piece).new('white')
  end

  def runner
    @view.prompt_move
    place
  end

end

# control = Control.new
# control.runner
# p control.model.board