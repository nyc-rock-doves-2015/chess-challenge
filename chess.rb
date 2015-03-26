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
pawn7 = Pawn.new('black', 4, 4)
board.place(pawn4, 1, 6)
board.place(pawn5, 2, 5)
board.place(pawn6, 4, 2)
board.place(pawn7, 4, 4)

# p pawn1.possible_moves
# p board
# p pawn4.possible_moves
p board.filter_moves(pawn4.possible_moves, pawn4)
p board.filter_moves(pawn5.possible_moves, pawn5)
p board.filter_moves(pawn6.possible_moves, pawn6)
p board.filter_moves(pawn7.possible_moves, pawn7)
puts "check next spot"
# p board.check_next_spot(pawn4, [0,-1], pawn4.x, pawn4.y, pawn4.move_count)
# p board.check_next_spot(pawn5, [0,1], pawn5.x, pawn5.y, pawn5.move_count)
p board.check_next_spot(pawn6, [0,1], pawn6.x, pawn6.y, pawn6.move_count)
p board.check_next_spot(pawn7, [0,-1], pawn7.x, pawn7.y, pawn7.move_count)
