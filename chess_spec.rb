require_relative 'game'
require_relative 'Board'

describe Gamel do
  let(:game1) {Gamel.new}

  describe "initialize" do
    it "contains attribute tasks which returns an array of Task Objects" do
      expect(game1.tasks).to be_a Array
      expect(game1.tasks[0]).to be_a Task
    end
  end

  describe "play" do
    let(:task1) {"Bake Cake"}
    it "adds a task to the tasks array" do
      game1.add(task1)
      expect{game1.tasks[-1].description}.to eq
      "Bake Cake"
    end
  end

  describe "turns" do

    let(:task2) {"Eat Cake"}
    game1.add(task2)
    it "takes an argument of the player's color" do
      game1.delete(14)
      expect{game1.tasks[13]}.to be nil
    end
  end

  describe "display_board" do
    let(:game1) {List.new}
    let(:task1) {"Bake Cake"}
    it "marks an X for a completed task" do
      game1.complete(task1)
      expect(game1.task1.to_s[1]).to eq "X"
    end
  end
end


describe View do
  let(:arg) {"Bake Cake"}
  let(:task1) {View.new(arg)}

  describe "turn_message" do
    it "initializes with one argument" do
      expect(task1.method(:initialize).arity).to eq 1
    end
  end

  describe "choose_piece" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "display_valid_moves" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "pick_move" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "pick_again" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "display_player_move" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "display_capture_move" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end
end

describe Board do
  let(:board1) {Board.new}
  describe "initializes" do
    it "initializes with an array of length 8" do
      expect(board1.list).to be_a List
    end

    it "initializes with a board display array containing chess character icons" do
  end

  describe "display" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "valid_moves" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "recursive_move_check" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "free_space?" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "move_one" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "out_of_bounds?" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "find_piece" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

   describe "string_to_index" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end
end

describe Piece do

   describe "color" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "moves" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "location" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end

  describe "name" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
  end
end

describe Pawn do
  describe "moves" do
    it "returns a string beginning with [" do
      expect(task1.to_s[0]).to eq "["
    end
    describe "capturing?"
    it "returns true if it is moving up 1 column and up 1 row"
  end
end

describe Rook do
     describe "name" do
    it "returns a string beginning with [" do
      expect(rook1.name]).to eq "rook"
    end
  end
end

describe Bishop do
end

desribe Queen do
end

describe King do
end

describe Knight do

end
