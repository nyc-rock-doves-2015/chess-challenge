# Model
class Board
  attr_accessor :board
  def initialize
    # Empty board: key = spot, value = piece
    @board = {
      'a1' => nil,
      'a2' => nil,
      'a3' => nil,
      'a4' => nil,
      'a5' => nil,
      'a6' => nil,
      'a7' => nil,
      'a8' => nil,
      'b1' => nil,
      'b2' => nil,
      'b3' => nil,
      'b4' => nil,
      'b5' => nil,
      'b6' => nil,
      'b7' => nil,
      'b8' => nil,
      'c1' => nil,
      'c2' => nil,
      'c3' => nil,
      'c4' => nil,
      'c5' => nil,
      'c6' => nil,
      'c7' => nil,
      'c8' => nil,
      'd1' => nil,
      'd2' => nil,
      'd3' => nil,
      'd4' => nil,
      'd5' => nil,
      'd6' => nil,
      'd7' => nil,
      'd8' => nil,
      'e1' => nil,
      'e2' => nil,
      'e3' => nil,
      'e4' => nil,
      'e5' => nil,
      'e6' => nil,
      'e7' => nil,
      'e8' => nil,
      'f1' => nil,
      'f2' => nil,
      'f3' => nil,
      'f4' => nil,
      'f5' => nil,
      'f6' => nil,
      'f7' => nil,
      'f8' => nil,
      'g1' => nil,
      'g2' => nil,
      'g3' => nil,
      'g4' => nil,
      'g5' => nil,
      'g6' => nil,
      'g7' => nil,
      'g8' => nil,
      'h1' => nil,
      'h2' => nil,
      'h3' => nil,
      'h4' => nil,
      'h5' => nil,
      'h6' => nil,
      'h7' => nil,
      'h8' => nil
    }
  end

  def new_game
    @board.map do |key, value|
      if key.to_s.include?('2')
        @board[key] = Pawn.new('white')
      elsif key.to_s.include?('7')
        @board[key] = Pawn.new('black')
      elsif key == 'a1'
        @board[key] = Rook.new('white')
      elsif key == 'h1'
        @board[key] = Rook.new('white')
      elsif key == 'a8'
        @board[key] = Rook.new('black')
      elsif key == 'h8'
        @board[key] = Rook.new('black')
      elsif key == 'b1'
        @board[key] = Knight.new('white')
      elsif key == 'g1'
        @board[key] = Knight.new('white')
      elsif key == 'b8'
        @board[key] = Knight.new('black')
      elsif key == 'g8'
        @board[key] = Knight.new('black')
      elsif key == 'c1'
        @board[key] = Bishop.new('white')
      elsif key == 'f1'
        @board[key] = Bishop.new('white')
      elsif key == 'c8'
        @board[key] = Bishop.new('black')
      elsif key == 'f8'
        @board[key] = Bishop.new('black')
      elsif key == 'd1'
        @board[key] = Queen.new('white')
      elsif key == 'd8'
        @board[key] = Queen.new('black')
      elsif key == 'e1'
        @board[key] = King.new('white')
      elsif key == 'e8'
        @board[key] = King.new('black')
      end
    end
  end
end

def move(piece, current, destination)
  # Refer back to self.hash to see what piece is in the 'current' position
  # destination?
  # !between?
  # empty?
  # enemy?
  # king?
  # friend?
  # BIG_HASH
    # key: piece type # value: hash
  #                             # key: current spot # value: destination
  # if BIG_HASH[piece][current].include?(destination)
  #   if @board[current]

end

class King
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Queen
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Bishop
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Knight
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Rook
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Pawn
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Moves
  def initialize
    # BIG HASH
  end
end


# board = Board.new

# p board.board
# board.new_game
# # p board.board
# board.board.each do |key, value|
#   print key
#   print value
#   puts
# end
