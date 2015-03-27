require_relative "chess_model.rb"

# class Game

board = Board.new

# pawn4 = Pawn.new('black', 1, 6)
# pawn5 = Pawn.new('white', 2, 5)
# pawn6 = Pawn.new('white', 4, 2)
# pawn7 = Pawn.new('black', 4, 3)
# board.place(pawn4, 1, 6)
# board.place(pawn5, 2, 5)
# board.place(pawn6, 4, 2)
# board.place(pawn7, 4, 3)

# pawn4.has_moved = true
# pawn5.has_moved = true

# rook1 = Rook.new('white', 4, 0)
# rook2 = Rook.new('black', 2, 7)
# board.place(rook1, 4, 0)
# board.place(rook2, 2, 7)

# bishop1 = Bishop.new('white', 0, 5)
# bishop2 = Bishop.new('black', 3, 2)
# board.place(bishop1, 0, 5)
# board.place(bishop2, 3, 2)

# queen1 = Queen.new('white', 4, 5)
# queen2 = Queen.new('black', 1, 4)
# board.place(queen1, 4, 5)
# board.place(queen2, 1, 4)

# king1 = King.new('white', 3, 1)
# king2 = King.new('black', 1, 5)
# board.place(king1, 3, 1)
# board.place(king2, 1, 5)

# knight1 = Knight.new('white', 6, 4)
# knight2 = Knight.new('black', 5, 7)
# board.place(knight1, 6, 4)
# board.place(knight2, 5, 7)

# puts knight1.class

pawn1 = Pawn.new('white', 0, 1)
pawn2 = Pawn.new('white', 1, 1)
pawn3 = Pawn.new('white', 2, 1)
pawn4 = Pawn.new('white', 3, 1)
pawn5 = Pawn.new('white', 4, 1)
pawn6 = Pawn.new('white', 5, 1)
pawn7 = Pawn.new('white', 6, 1)
pawn8 = Pawn.new('white', 7, 1)

board.place(pawn1, 0, 1)
board.place(pawn2, 1, 1)
board.place(pawn3, 2, 1)
board.place(pawn4, 3, 1)
board.place(pawn5, 4, 1)
board.place(pawn6, 5, 1)
board.place(pawn7, 6, 1)
board.place(pawn8, 7, 1)

rook1 = Rook.new('white', 0, 0)
rook2 = Rook.new('white', 7, 0)
knight1 = Knight.new('white', 1, 0)
knight2 = Knight.new('white', 6, 0)
bishop1 = Bishop.new('white', 2, 0)
bishop2 = Bishop.new('white', 5, 0)
king1 = King.new('white', 4, 0)
queen1 = Queen.new('white', 3, 0)

board.place(rook1, 0, 0)
board.place(rook2, 7, 0)
board.place(knight1, 1, 0)
board.place(knight2, 6, 0)
board.place(bishop1, 2, 0)
board.place(bishop2, 5, 0)
board.place(king1, 4, 0)
board.place(queen1, 3, 0)

pawn11 = Pawn.new('black', 0, 6)
pawn21 = Pawn.new('black', 1, 6)
pawn31 = Pawn.new('black', 2, 6)
pawn41 = Pawn.new('black', 3, 6)
pawn51 = Pawn.new('black', 4, 6)
pawn61 = Pawn.new('black', 5, 6)
pawn71 = Pawn.new('black', 6, 6)
pawn81 = Pawn.new('black', 7, 6)

board.place(pawn11, 0, 6)
board.place(pawn21, 1, 6)
board.place(pawn31, 2, 6)
board.place(pawn41, 3, 6)
board.place(pawn51, 4, 6)
board.place(pawn61, 5, 6)
board.place(pawn71, 6, 6)
board.place(pawn81, 7, 6)

rook11 = Rook.new('black', 0, 7)
rook21 = Rook.new('black', 7, 7)
knight11 = Knight.new('black', 1, 7)
knight21 = Knight.new('black', 6, 7)
bishop11 = Bishop.new('black', 2, 7)
bishop21 = Bishop.new('black', 5, 7)
king11 = King.new('black', 4, 7)
queen11 = Queen.new('black', 3, 7)

board.place(rook11, 0, 7)
board.place(rook21, 7, 7)
board.place(knight11, 1, 7)
board.place(knight21, 6, 7)
board.place(bishop11, 2, 7)
board.place(bishop21, 5, 7)
board.place(king11, 4, 7)
board.place(queen11, 3, 7)

def clear_screen
  print "\e[2J\e[H"
end

players = ['white', 'black']

while board.game_complete? == false

  players.each_with_index do |player, index|
    clear_screen
    puts board
    board.turn += 1
    puts "#{player}'s turn"
    print "#{player}, your move? "
    piece_position = gets.chomp
    until board.validate_piece(player, piece_position) && !board.filter_moves(board.get_piece(piece_position)).empty?
      puts "You need to select another piece"
      print "#{player}, your move? "
      piece_position = gets.chomp
    end
    piece = board.get_piece(piece_position)
    puts "moves for #{player} #{piece.image} #{piece_position}: #{board.convert_to_chess_notation(board.filter_moves(piece))}"
    print "#{player}, move #{piece.image} #{piece_position} where? "
    move_position = gets.chomp
    until board.convert_to_chess_notation(board.filter_moves(piece)).include?(move_position)
      puts "Please enter valid move"
      print "#{player}, move #{piece.image} #{piece_position} where? "
      move_position = gets.chomp
    end
    if board.get_piece(move_position) != "-"
      puts "#{player} captured #{players[index - 1]}'s #{board.get_piece(move_position).image} at #{move_position}"
    end
    if piece.type == :king && move_position == "c1"
      board.place(board.board[0][0], 3, 0)
    elsif piece.type == :king && move_position == "g1"
      board.place(board.board[7][0], 5, 0)
    elsif piece.type == :king && move_position == "c8"
      board.place(board.board[0][7], 3, 7)
    elsif piece.type == :king && move_position == "g8"
      board.place(board.board[7][7], 5, 7)
    end
    board.place(piece, board.get_row(move_position), board.get_col(move_position), true)
    p piece
    if piece.type == :pawn && piece.y == 7
      puts "What piece do you want to promote your pawn to"
      puts "Q:♛ R:♜ B:♝ K:♞"
      promotion = gets.chomp.upcase
      case promotion
      when "Q"
        board.place(Queen.new('white', piece.x, piece.y), piece.x, piece.y)
      when "R"
        board.place(Rook.new('white', piece.x, piece.y), piece.x, piece.y)
      when "B"
        board.place(Bishop.new('white', piece.x, piece.y), piece.x, piece.y)
      when "K"
        board.place(Knight.new('white', piece.x, piece.y), piece.x, piece.y)
      end
    end
    if piece.type == :pawn && piece.y == 0
      puts "What piece do you want to promote your pawn to"
      puts "Q:♛ R:♜ B:♝ K:♞"
      promotion = gets.chomp.upcase
      case promotion
      when "Q"
        board.place(Queen.new('black', piece.x, piece.y), piece.x, piece.y)
      when "R"
        board.place(Rook.new('black', piece.x, piece.y), piece.x, piece.y)
      when "B"
        board.place(Bishop.new('black', piece.x, piece.y), piece.x, piece.y)
      when "K"
        board.place(Knight.new('black', piece.x, piece.y), piece.x, piece.y)
      end
    end
    if board.game_complete?
      puts "#{player} wins!"
      break
    end
    sleep(1)
  end

end

