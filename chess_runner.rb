=begin

 Viewer

 methods:
 greeting--promt to user
 ability to make a test board --place pieces
 to_s to display board
 move prompt
 valid? move evaluation

 Controller

 model = Model.new ----> empty board
 view = View.new ------> view
 new game? = True ----> model
 move(home_position, possiable_position) ---->model valid?


 Model

 board = Array.new(8)
 pieces hash = hashyhash with two pawns for b/w and 2 bishops for b/w with the key of the first hash == name of piece and key== position on board--value---> possible moves.
 valid?
  * destination possible?
  * empty?
  * any? between? pieces
  * if empty == true ----> new position
    else
    * if !empty enmemy piece ----> capture ---> new position of piece
    * if !empty and piece is friend ----> invalid


=end


#Model

class board
  def initialize
  end
end

class pieces
  def initialize
  end
end

#Viewer
class game
  def initialize
  end
end


#Controller

def move

end

def valid_move?

end

def captured?
end



