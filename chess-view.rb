class View
  attr_accessor :piece, :location, :color

  def initialize
  end

  def prompt_move
    puts "Which piece would you like to place? (King, Queen, Bishop, Knight, Rook, Pawn)"
    @piece = gets.chomp
    puts "Which color? (Black or White)"
    @color = gets.chomp
    puts "Where would you like to place the piece? Use chess notation (i.e. a2, e7..)"
    @location = gets.chomp
  end

  def to_s(hash)
    board_array = []
    hash.values.each_slice(8) do |pieces|
      board_array << pieces
    end
    board_array << ['a','b','c','d','e','f','g','h']
    row_num = 8
    board_array.each do |row|
      if row_num > 0
        print row_num.to_s + "  "
      else
        print "     "
      end
      row.each do |piece|
        if piece.is_a? Rook
          print "♜"
        elsif piece.is_a? Knight
          print "♞"
        elsif piece.is_a? Bishop
          print "♝"
        elsif piece.is_a? Queen
          print "♛"
        elsif piece.is_a? King
          print "♚"
        elsif piece.is_a? Pawn
          print "♟"
        elsif piece == nil
          print "  "
        else
          print piece
        end
        print "  "
      end
      row_num -= 1
      puts
    end
  end
end


# view = View.new
