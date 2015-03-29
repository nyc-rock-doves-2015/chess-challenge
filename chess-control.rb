require_relative 'chess-model'
require_relative 'chess-view'
require_relative 'possible-moves-hash'

require 'byebug'

WHITE_SQ_FILES = ['B', 'D', 'F', 'H']
BLACK_SQ_FILES = ['A', 'C', 'E', 'G']

class Control
  attr_accessor :promotion_spot, :view, :model

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
    if current.length != 2 || destination.length != 2
      @view.invalid_prompt
      return false
    end

    @piece_to_move = @model.board[current]
    @tile_to_go = @model.board[destination]

    if @model.board[current] == nil
      puts "There's no piece to move at #{current}"
      current_valid = false
    else
      current_valid = true
    end

    if MOVES[@model.board[current].class.name.downcase][current].include?(destination)
      if @model.board[destination] == nil
        destination_valid = true
      else #if not empty
        if @model.board[current].color == @model.board[destination].color
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
    @model.board.each do |spot, piece|
      if spot.include?('1') && piece.class.name == "Black_pawn"
        @promotion_spot = spot
      end
    end

    @model.board.each do |spot, piece|
      if spot.include?('8') && piece.class.name == "White_pawn"
        @promotion_spot = spot
      end
    end

    if @promotion_spot == nil
      return false
    else
      return true
    end
  end

  def promote
    # ASK ABOUT THIS VARIABLE USAGE
    # promotion_tile = @model.board[@promotion_spot]

    if @promotion_spot.include?('1')
      if @view.revival_piece == "Bishop"
        if BLACK_SQ_FILES.include?(@promotion_spot[0])
          @model.board[@promotion_spot] = Black_sq_bishop.new('black')
          @promotion_spot = nil
        elsif WHITE_SQ_FILES.include?(@promotion_spot[0])
          @model.board[@promotion_spot] = White_sq_bishop.new('black')
          @promotion_spot = nil
        end
      else
        @model.board[@promotion_spot] = Object.const_get(@view.revival_piece).new("black")
        @promotion_spot = nil
      end
    elsif @promotion_spot.include?('8')
      if @view.revival_piece == "Bishop"
        if BLACK_SQ_FILES.include?(@promotion_spot[0])
          @model.board[@promotion_spot] = Black_sq_bishop.new('white')
          @promotion_spot = nil
        elsif WHITE_SQ_FILES.include?(@promotion_spot[0])
          @model.board[@promotion_spot] = White_sq_bishop.new('white')
          @promotion_spot = nil
        end
      else
        @model.board[@promotion_spot] = Object.const_get(@view.revival_piece).new("white")
        @promotion_spot = nil
      end
    end
  end

  def promotion_cycle
    check_promote?
    if @promotion_spot != nil
      @view.prompt_promote
      promote
    end
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

  def test_runner

    @view.to_s(@model.board)

    @view.test_prompt
    place
    @view.to_s(@model.board)

    promotion_cycle
    @view.to_s(@model.board)

    @view.test_prompt
    place
    @view.to_s(@model.board)

    promotion_cycle
    @view.to_s(@model.board)

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

        promotion_cycle
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

        promotion_cycle
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
