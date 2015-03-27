
def move_direction(start, dest)
  start[0] != dest[0] && start[1] != dest[1] ? "diagonal" : "linear"
end

def check_linear(start, dest)
  if start[0] == dest[0]
    file = start[0]
    (start[1]..dest[1]).each { |rank|
    #valid?(start, file + rank)}
    puts "fwd or bkwd #{start}, #{file}:#{rank}"}
  elsif start[1] == dest[1]
    rank = start[1]
    (start[0]..dest[0]).each { |file|
    #valid?(start, file + rank)}
    puts "left or right #{start}, #{file}:#{rank}"}
  end
end

def check_diagonal(start, dest)
  current_check = start
  if start[0] < dest[0] && start[1] < dest[1] #up-right
    puts "upright"
    until current_check == dest
      current_check = ((current_check[0].ord + 1).chr + (current_check[1].to_i + 1).to_s)
      puts current_check
    end

  elsif start[0] > dest[0] && start[1] < dest[1] #up-left
    puts "upleft"
    until current_check == dest
      current_check = ((current_check[0].ord - 1).chr + (current_check[1].to_i + 1).to_s)
      puts current_check
    end

  elsif start[0] < dest[0] && start[1] > dest[1] #down-right
    puts "downright"
    until current_check == dest
      current_check = ((current_check[0].ord + 1).chr + (current_check[1].to_i - 1).to_s)
      puts current_check
    end

  elsif start[0] > dest[0] && start[1] > dest[1] #down-left
    puts "downleft"
    until current_check == dest
      current_check = ((current_check[0].ord - 1).chr + (current_check[1].to_i - 1).to_s)
      puts current_check
    end
  end
end

start, dest = "H8", "A1"
check_linear(start, dest) if move_direction(start, dest) == "linear"
check_diagonal(start, dest) if move_direction(start, dest) == "diagonal"

start, dest = "A8", "H1"
check_linear(start, dest) if move_direction(start, dest) == "linear"
check_diagonal(start, dest) if move_direction(start, dest) == "diagonal"

start, dest = "A1", "H8"
check_linear(start, dest) if move_direction(start, dest) == "linear"
check_diagonal(start, dest) if move_direction(start, dest) == "diagonal"

start, dest = "H1", "A8"
check_linear(start, dest) if move_direction(start, dest) == "linear"
check_diagonal(start, dest) if move_direction(start, dest) == "diagonal"
