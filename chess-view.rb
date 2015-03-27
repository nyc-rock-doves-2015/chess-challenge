class View
  attr_accessor :piece, :location, :color, :start_input, :current, :destination
  # attr_reader :start_input

  def initialize
  end

  def test_prompt
    puts "Which piece would you like to place? (King, Queen, Bishop, Knight, Rook, Pawn)"
    @piece = gets.chomp
    puts "Which color? (Black or White)"
    @color = gets.chomp
    puts "Where would you like to place the piece? Use chess notation (i.e. A2, E7..)"
    @location = gets.chomp
  end

  def start_prompt
    puts "Do you want to play a game? (y/n)"
    @start_input = gets.chomp
    choices = ['y','n']
    if !choices.include?(@start_input.downcase)
      puts "Invalid entry."
      start_prompt
    end
  end

  def invalid_prompt
    puts "Invalid entry or move not possible."
  end

  def current_prompt
    puts "Initial Spot?"
    @current = gets.chomp.upcase
  end
  def destination_prompt
    puts "Destination?"
    @destination = gets.chomp.upcase
  end

  def goodbye
    puts "Goodbye."
  end

  def to_s(hash)
    board_array = []
    hash.values.each_slice(8) do |pieces|
      board_array << pieces
    end
    board_array << ['A','B','C','D','E','F','G','H']
    row_num = 8
    board_array.each do |row|
      if row_num > 0
        print row_num.to_s + "  "
      else
        print "    "
      end
      row.each do |piece|
        if piece == nil
          print "  "
        elsif piece.is_a? String
          print piece + " "
        else
          print piece.glyph + " "
        end
        print "  "
      end
      row_num -= 1
      puts
    end
  end
end


# view = View.new
