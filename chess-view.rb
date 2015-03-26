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
end