require_relative "chess_model.rb"

# class Game

board = Board.new
# pawn1 = Pawn.new('white', 3, 4)
# pawn2 = Pawn.new('white', 3, 5)
# pawn3 = Pawn.new('black', 4, 5)
# board.place(pawn1, 3, 4)
# board.place(pawn2, 3, 5)
# board.place(pawn3, 4, 5)

pawn4 = Pawn.new('black', 1, 6)
pawn5 = Pawn.new('white', 2, 5)
pawn6 = Pawn.new('white', 4, 2)
pawn7 = Pawn.new('black', 4, 3)
board.place(pawn4, 1, 6)
board.place(pawn5, 2, 5)
board.place(pawn6, 4, 2)
board.place(pawn7, 4, 3)

pawn4.has_moved = true
pawn5.has_moved = true

# puts "pawn5"
# p board.filter_moves(pawn5.possible_moves, pawn5)

rook1 = Rook.new('white', 4, 0)
rook2 = Rook.new('black', 2, 7)
board.place(rook1, 4, 0)
board.place(rook2, 2, 7)

# p board.filter_moves(rook1)
# p board.filter_moves(rook2)
# board.place(rook2, 2, 5)

bishop1 = Bishop.new('white', 0, 5)
bishop2 = Bishop.new('black', 3, 2)
board.place(bishop1, 0, 5)
board.place(bishop2, 3, 2)
# p board.filter_moves(bishop1)
# p board.filter_moves(bishop2)


queen1 = Queen.new('white', 4, 5)
queen2 = Queen.new('black', 1, 4)
board.place(queen1, 4, 5)
board.place(queen2, 1, 4)
# p board.filter_moves(queen1)
# p board.filter_moves(queen2)

king1 = King.new('white', 3, 1)
king2 = King.new('black', 1, 5)
board.place(king1, 3, 1)
board.place(king2, 1, 5)
# p board.filter_moves(king1)
# p board.filter_moves(king2)

knight1 = Knight.new('white', 6, 4)
knight2 = Knight.new('black', 5, 7)
board.place(knight1, 6, 4)
board.place(knight2, 5, 7)
# p board.filter_moves(knight1)
# p board.filter_moves(knight2)

# print rook1.image
# print rook2.image

# p board
puts board.to_s

players = ['white', 'black']

while board.game_complete? == false

  players.each do |player|
    puts "#{player}'s turn"
    print "#{player}, your move?"
    piece_position = gets.chomp
    until board.get_piece(player, piece_position)
      puts "You need to select your piece"
      print "#{player}, your move?"
      piece_position = gets.chomp
    end
    # print "moves for #{}"

  end



end

