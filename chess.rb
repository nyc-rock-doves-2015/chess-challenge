require_relative "chess_model.rb"

board = Board.new
pawn1 = Pawn.new('white', 3, 4)
pawn2 = Pawn.new('white', 3, 5)
pawn3 = Pawn.new('white', 4, 5)
board.place(pawn1, 3, 4)
board.place(pawn2, 3, 5)
p pawn1.possible_moves
p board
p board.filter_moves(pawn1.possible_moves, pawn1)
