class Board
  attr_accessor :board
  def initialize
    @board = {
      'A8' => nil,
      'B8' => nil,
      'C8' => nil,
      'D8' => nil,
      'E8' => nil,
      'F8' => nil,
      'G8' => nil,
      'H8' => nil,
      'A7' => nil,
      'B7' => nil,
      'C7' => nil,
      'D7' => nil,
      'E7' => nil,
      'F7' => nil,
      'G7' => nil,
      'H7' => nil,
      'A6' => nil,
      'B6' => nil,
      'C6' => nil,
      'D6' => nil,
      'E6' => nil,
      'F6' => nil,
      'G6' => nil,
      'H6' => nil,
      'A5' => nil,
      'B5' => nil,
      'C5' => nil,
      'D5' => nil,
      'E5' => nil,
      'F5' => nil,
      'G5' => nil,
      'H5' => nil,
      'A4' => nil,
      'B4' => nil,
      'C4' => nil,
      'D4' => nil,
      'E4' => nil,
      'F4' => nil,
      'G4' => nil,
      'H4' => nil,
      'A3' => nil,
      'B3' => nil,
      'C3' => nil,
      'D3' => nil,
      'E3' => nil,
      'F3' => nil,
      'G3' => nil,
      'H3' => nil,
      'A2' => nil,
      'B2' => nil,
      'C2' => nil,
      'D2' => nil,
      'E2' => nil,
      'F2' => nil,
      'G2' => nil,
      'H2' => nil,
      'A1' => nil,
      'B1' => nil,
      'C1' => nil,
      'D1' => nil,
      'E1' => nil,
      'F1' => nil,
      'G1' => nil,
      'H1' => nil
    }
  end

  def new_game
    @board.map do |key, value|
      if key.to_s.include?('2')
        @board[key] = White_pawn.new('white')
      elsif key.to_s.include?('7')
        @board[key] = Black_pawn.new('black')
      elsif key == 'A1'
        @board[key] = Rook.new('white')
      elsif key == 'H1'
        @board[key] = Rook.new('white')
      elsif key == 'A8'
        @board[key] = Rook.new('black')
      elsif key == 'H8'
        @board[key] = Rook.new('black')
      elsif key == 'B1'
        @board[key] = Knight.new('white')
      elsif key == 'G1'
        @board[key] = Knight.new('white')
      elsif key == 'B8'
        @board[key] = Knight.new('black')
      elsif key == 'G8'
        @board[key] = Knight.new('black')
      elsif key == 'C1'
        @board[key] = Black_sq_bishop.new('white')
      elsif key == 'F1'
        @board[key] = White_sq_bishop.new('white')
      elsif key == 'C8'
        @board[key] = White_sq_bishop.new('black')
      elsif key == 'F8'
        @board[key] = Black_sq_bishop.new('black')
      elsif key == 'D1'
        @board[key] = Queen.new('white')
      elsif key == 'D8'
        @board[key] = Queen.new('black')
      elsif key == 'E1'
        @board[key] = King.new('white')
      elsif key == 'E8'
        @board[key] = King.new('black')
      end
    end
  end


  def move_piece(current, destination)
    @board[destination] = @board[current]
    @board[current] = nil
  end
end

class King
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    if @color == "black"
      @glyph = "♚"
    elsif @color == 'white'
      @glyph = "♔"
    end
  end
end

class Queen
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    if @color == "black"
      @glyph = "♛"
    else
      @glyph = "♕"
    end
  end
end

class Black_sq_bishop
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    if @color == 'black'
      @glyph = "♝"
    elsif @color == 'white'
      @glyph = "♗"
    end
  end
end

class White_sq_bishop
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    if @color == 'black'
      @glyph = "♝"
    elsif @color == 'white'
      @glyph = "♗"
    end
  end
end

class Knight
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    if @color == "black"
      @glyph = "♞"
    else
      @glyph = "♘"
    end
  end
end

class Rook
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    if @color == "black"
      @glyph = "♜"
    else
      @glyph = "♖"
    end
  end
end

class Black_pawn
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    @glyph = "♟"
  end
end

class White_pawn
  attr_reader :color, :glyph
  def initialize(color)
    @color = color
    @glyph = "♙"
  end
end