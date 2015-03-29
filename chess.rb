require_relative 'chess_model'

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = ['white', 'black']
  end

  def test_board
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

    rook1 = Rook.new('white', 4, 0)
    rook2 = Rook.new('black', 2, 2)
    board.place(rook1, 4, 0)
    board.place(rook2, 2, 2)

    bishop1 = Bishop.new('white', 0, 5)
    bishop2 = Bishop.new('black', 3, 2)
    board.place(bishop1, 0, 5)
    board.place(bishop2, 3, 2)

    queen1 = Queen.new('white', 4, 5)
    queen2 = Queen.new('black', 1, 4)
    board.place(queen1, 4, 5)
    board.place(queen2, 1, 4)

    king1 = King.new('white', 3, 1)
    king2 = King.new('black', 1, 5)
    board.place(king1, 3, 1)
    board.place(king2, 1, 5)

    knight1 = Knight.new('white', 6, 4)
    knight2 = Knight.new('black', 5, 7)
    board.place(knight1, 6, 4)
    board.place(knight2, 5, 7)
  end

  def real_board

    #white
    pawn1 = Pawn.new('white', 0, 1)
    pawn2 = Pawn.new('white', 1, 1)
    pawn3 = Pawn.new('white', 2, 1)
    pawn4 = Pawn.new('white', 3, 1)
    pawn5 = Pawn.new('white', 4, 1)
    pawn6 = Pawn.new('white', 5, 1)
    pawn7 = Pawn.new('white', 6, 1)
    pawn8 = Pawn.new('white', 7, 1)
    rook1 = Rook.new('white', 0, 0)
    rook2 = Rook.new('white', 7, 0)
    knight1 = Knight.new('white', 1, 0)
    knight2 = Knight.new('white', 6, 0)
    bishop1 = Bishop.new('white', 2, 0)
    bishop2 = Bishop.new('white', 5, 0)
    king1 = King.new('white', 4, 0)
    queen1 = Queen.new('white', 3, 0)

    board.place(pawn1, 0, 1)
    board.place(pawn2, 1, 1)
    board.place(pawn3, 2, 1)
    board.place(pawn4, 3, 1)
    board.place(pawn5, 4, 1)
    board.place(pawn6, 5, 1)
    board.place(pawn7, 6, 1)
    board.place(pawn8, 7, 1)
    board.place(rook1, 0, 0)
    board.place(rook2, 7, 0)
    board.place(knight1, 1, 0)
    board.place(knight2, 6, 0)
    board.place(bishop1, 2, 0)
    board.place(bishop2, 5, 0)
    board.place(king1, 4, 0)
    board.place(queen1, 3, 0)

    #black
    pawn11 = Pawn.new('black', 0, 6)
    pawn21 = Pawn.new('black', 1, 6)
    pawn31 = Pawn.new('black', 2, 6)
    pawn41 = Pawn.new('black', 3, 6)
    pawn51 = Pawn.new('black', 4, 6)
    pawn61 = Pawn.new('black', 5, 6)
    pawn71 = Pawn.new('black', 6, 6)
    pawn81 = Pawn.new('black', 7, 6)
    rook11 = Rook.new('black', 0, 7)
    rook21 = Rook.new('black', 7, 7)
    knight11 = Knight.new('black', 1, 7)
    knight21 = Knight.new('black', 6, 7)
    bishop11 = Bishop.new('black', 2, 7)
    bishop21 = Bishop.new('black', 5, 7)
    king11 = King.new('black', 4, 7)
    queen11 = Queen.new('black', 3, 7)

    board.place(pawn11, 0, 6)
    board.place(pawn21, 1, 6)
    board.place(pawn31, 2, 6)
    board.place(pawn41, 3, 6)
    board.place(pawn51, 4, 6)
    board.place(pawn61, 5, 6)
    board.place(pawn71, 6, 6)
    board.place(pawn81, 7, 6)
    board.place(rook11, 0, 7)
    board.place(rook21, 7, 7)
    board.place(knight11, 1, 7)
    board.place(knight21, 6, 7)
    board.place(bishop11, 2, 7)
    board.place(bishop21, 5, 7)
    board.place(king11, 4, 7)
    board.place(queen11, 3, 7)
  end

  def clear_screen
    print "\e[2J\e[H"
  end

  def play
    while board.game_complete == false
      players.each_with_index do |player, index|
        clear_screen
        puts board
        board.turn += 1
        if board.no_moves?(player)
          if board.check?(player)
            puts "Checkmate!"
            puts "#{players[index - 1]} wins"
            board.game_complete = true
            break
          else
            puts "Stalemate!"
            puts "Game is a draw"
            board.game_complete = true
            break
          end
        end
        piece, piece_position = validate_piece(player,board)
        filtered_moves = board.filter_moves(piece)
        valid_moves = board.remove_bad_moves(filtered_moves, piece)
        move_position = validate_move_selection(player, piece, piece_position, board, valid_moves)
        until move_position != ""
          piece, piece_position = validate_piece(player,board)
          filtered_moves = board.filter_moves(piece)
          valid_moves = board.remove_bad_moves(filtered_moves, piece)
          move_position = validate_move_selection(player, piece, piece_position, board, valid_moves)
        end
        if board.get_piece(move_position) != "-"
          puts "#{player} captured #{players[index - 1]}'s #{board.get_piece(move_position).image} at #{move_position}"
        end
        castling(piece, move_position, board)
        row, col = board.split_coordinates(move_position)
        board.place(piece, row, col, true)
        promotion(piece,board,player,7) if player == "white"
        promotion(piece,board,player,0) if player == "black"
        board.save_board_state
        if board.board_state_hash.values.include?(3)
          puts "Threefold repetition: game is draw"
          board.game_complete = true
          break
        end
        board.game_check
        if board.game_complete == true
          puts "#{player} wins!"
          break
        end
        board.insufficient
        if board.game_complete == true
          puts "insufficient material: game is a draw!"
          break
        end
        sleep(1)
      end
    end
  end

  def castling(piece, move_position, board)
    if piece.class == King && move_position == "c1" && piece.has_moved == false
      board.place(board.board[0][0], 3, 0)
    elsif piece.class == King && move_position == "g1" && piece.has_moved == false
      board.place(board.board[7][0], 5, 0)
    elsif piece.class == King && move_position == "c8" && piece.has_moved == false
      board.place(board.board[0][7], 3, 7)
    elsif piece.class == King && move_position == "g8" && piece.has_moved == false
      board.place(board.board[7][7], 5, 7)
    end
  end

  def validate_move_selection(player, piece, piece_position, board, valid_moves)
    puts "moves for #{player} #{piece.image} #{piece_position}: #{board.convert_to_chess_notation(valid_moves)}"
    puts "press enter to select another piece."
    print "#{player}, move #{piece.image} #{piece_position} where? "
    move_position = gets.chomp
    until board.convert_to_chess_notation(valid_moves).include?(move_position)
      puts "Please enter valid move"
      print "#{player}, move #{piece.image} #{piece_position} where? "
      move_position = gets.chomp
    end
    move_position
  end

  def validate_piece(player, board)
    puts "#{player}'s turn"
    puts "You are in check!" if board.check?(player)
    print "#{player}, your move? "
    piece_position = gets.chomp
    piece = board.get_piece(piece_position)
    until board.validate_piece(player, piece_position) && !board.remove_bad_moves(board.filter_moves(piece), piece).empty?
      puts "You need to select another piece"
      print "#{player}, your move? "
      piece_position = gets.chomp
      piece = board.get_piece(piece_position)
    end
    [piece, piece_position]
  end

  def promotion(piece,board,player,row)
    if piece.class == Pawn && piece.y == row
      puts "What piece do you want to promote your pawn to"
      puts "Q:\u2655 R:\u2656 B:\u2657 K:\u2658"
      promotion = gets.chomp.upcase
      until promotion == "Q" || promotion == "R" || promotion == "B" || promotion == "K"
        puts "Choose a valid piece"
        puts "Q:\u2655 R:\u2656 B:\u2657 K:\u2658"
        promotion = gets.chomp.upcase
      end
      case promotion
      when "Q"
        board.place(Queen.new(player, piece.x, piece.y), piece.x, piece.y)
      when "R"
        board.place(Rook.new(player, piece.x, piece.y), piece.x, piece.y)
      when "B"
        board.place(Bishop.new(player, piece.x, piece.y), piece.x, piece.y)
      when "K"
        board.place(Knight.new(player, piece.x, piece.y), piece.x, piece.y)
      end
    end
  end

end
