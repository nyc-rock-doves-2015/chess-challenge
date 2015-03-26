require_relative "chess_model.rb"

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

puts "pawn5"
# p board.filter_moves(pawn5.possible_moves, pawn5)

rook1 = Rook.new('white', 4, 0)
rook2 = Rook.new('black', 1, 7)
board.place(rook1, 4, 0)
board.place(rook2, 1, 7)

p board.filter_moves(rook1)
